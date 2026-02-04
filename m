Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D7BEA7941
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 19:11:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vniEZ-0000Mt-7i; Wed, 04 Feb 2026 14:08:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vniEY-0000MY-Bn
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:08:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vniEV-0000iW-CL
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:08:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770232090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XbRS2mE0WiX1GqSqk8vRkTQsmW0FHwhJ6xfUEOYJc7g=;
 b=Fg9eWGn+E+xHsZvPrU3IdmQI77qqWLzKA1GQgsI8Z2Rh+TTqajUJ0Qro17OhWaN10cWdU+
 LnkflDotGt0LZ1nsJ4LGPy2J4JT5nZFnSK+KXtz2Y8KKnUE+tumNLRoE/BBwHt07F6P8Nj
 L6vZJsRbm/F0WH6wp9fuyLEYSYRqyeM=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-dzsOid-2NMCP06mIEcalaw-1; Wed, 04 Feb 2026 14:08:09 -0500
X-MC-Unique: dzsOid-2NMCP06mIEcalaw-1
X-Mimecast-MFC-AGG-ID: dzsOid-2NMCP06mIEcalaw_1770232089
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-501473ee94fso8672571cf.3
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 11:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770232089; x=1770836889; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XbRS2mE0WiX1GqSqk8vRkTQsmW0FHwhJ6xfUEOYJc7g=;
 b=ep4D498ysP+MGTkSB9s55VB9v42AbGQoR1RrnsVZsy9AuEOLD+9dfvh0VB9aZmUXr5
 dzC5uHWoTVudExfO9yqyUci/o/KxBNFlVGPnUVHp0/2x/6uOPa/X6r+tfGEWxE4BNiLF
 eecO2RLcblAm5zC4HgB/vRO6RxOWDk4HVgGnghf/P/XSmmt5fSfI3vJps0+JZbKAe7B9
 Ur9wectgu4LwU1RHVseSksRsJFAwsXjCEX4W6z9KfelaryYC+p7ATjcO3cpnt6DAw+n4
 4qTlUwagqIGcktCv/2vVRzFO3eA1C7g2StRxZ8xwpzgB8l9bAIAxzOPyG77J7O1piIDJ
 jciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770232089; x=1770836889;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XbRS2mE0WiX1GqSqk8vRkTQsmW0FHwhJ6xfUEOYJc7g=;
 b=TA5v011u3nAktrAs5f6lmGcipz6CwWfY65C3tCT9O2hhEvPVqvvJdpsyuh9iotDnqM
 30CuiVUOVO7JfTMUdd4XsSMS6ioKzKi7lLu7km9vzR8Etrspnm9OPQ+ZCvcuLbl4UWuJ
 7dFaFBEVlT6H71qvUPx4feJNWz+wqeuBVfDOc2MQcbFjp9UCaR58G9gn/fjBnWzSZiDy
 WlReDhJKN57GOVGou4TFudHRYVl5TkMe0NgWnvzNymanibtdmksBICXxwh29E00GlvIS
 kbBOb2KAGOpa4n5+Xq6Msii9abmbQWbD49rg6+8sxzBuoHleqUIFcpFZayg6p+ULArSv
 TN9Q==
X-Gm-Message-State: AOJu0Yy5QaHUcXdeF7e928tZDZRLIt1d1bNkePbg3ieRoIPSftn8ZONo
 C944TPu5DotNwmktHNvT7/rqj/gKcdlkY2siCv4ihsl/0KSchjqmBd7rnfCaAmwTIq8MlhZ5EXN
 yeae4h0KianKS2EtkMqYFMoQ/d87E8zB/hR6TvEsuW5Vbsj8k98WgrLUV
X-Gm-Gg: AZuq6aKhue8yAtt9DWzPNmEQ5NdwOUe2sdAG2JcH3LRqKcRp3YdsOXyr+J9z7mg9Pys
 5eSkXTuOP30sRzPhAwBYex2mlFmqTOX8C9gLouTqDVX7+gR8yHrZ4TqXrj9OZEd/P6GCDBkpC56
 Mc4FJk4CaDWJsGyUQ5ZbbX72/0CJhIUXWUWGFUjUA1DXvBUawJMMExSFnpSF2u+mPE/ckc9ebPW
 7LyNf6wuiaFYgdsUp6j49I6UK5NNh2/X88pS+YFpOl8gnujtnfS7+lEqKQ8QJ0FtvU9JTcYHIO0
 gAeRYTY+qHqiV6bXJMRpyKWyEE5JZw5FNkV+lbldCb8aY31XZS2BAdxM4RvlQJVywHyo3H6aYvi
 czLI=
X-Received: by 2002:ac8:5803:0:b0:4ed:2164:5018 with SMTP id
 d75a77b69052e-5061c1d4507mr50927451cf.80.1770232088765; 
 Wed, 04 Feb 2026 11:08:08 -0800 (PST)
X-Received: by 2002:ac8:5803:0:b0:4ed:2164:5018 with SMTP id
 d75a77b69052e-5061c1d4507mr50926981cf.80.1770232088321; 
 Wed, 04 Feb 2026 11:08:08 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89521cf89fasm25251496d6.31.2026.02.04.11.08.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 11:08:07 -0800 (PST)
Date: Wed, 4 Feb 2026 14:08:05 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, berrange@redhat.com
Subject: Re: [PATCH v2 3/4] tests/functional/migration: Use the migrate_vms
 helper
Message-ID: <aYOZFSb3_yWJRl9S@x1.local>
References: <20260204172332.21367-1-farosas@suse.de>
 <20260204172332.21367-4-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260204172332.21367-4-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Feb 04, 2026 at 02:23:31PM -0300, Fabiano Rosas wrote:
> Change do_migrate() to call the migrate_vms() helper and provide it
> with the two VMs already created. Rename do_migrate -> migrate and
> adjust the callers.
> 
> While here, standardize on the "src" and "dst" names.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


