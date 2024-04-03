Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D39CD128A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 15:38:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rs2hE-0007iR-9J; Wed, 03 Apr 2024 11:38:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@cloud.com>)
 id 1rs2hC-0007iE-Md
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 11:38:38 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anthony.perard@cloud.com>)
 id 1rs2hA-0006fm-Qr
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 11:38:38 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-415515178ceso36027255e9.0
 for <qemu-devel@nongnu.org>; Wed, 03 Apr 2024 08:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.com; s=cloud; t=1712158714; x=1712763514; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=McZLVRCOssNn1B5GeXV8ZbbcBKqz5IaOwviQeH7wZuY=;
 b=YUkkIT/kmlk4yqMkVlyCYiTbxgTnM6pg51bLlT763lnMgcBVakBiDkDbWnmcs21iIr
 BJOVjnLDbLdG40ilXBJ8B2plgbZ9ngw4YkRsPdShfr3BDcEbE1n1sEdtyDtZPWmi5YNR
 pch+WU8n9V7OsTNr2BsuUK7WBaNBr8m9szPuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712158714; x=1712763514;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=McZLVRCOssNn1B5GeXV8ZbbcBKqz5IaOwviQeH7wZuY=;
 b=aJIQtJXdXUJmABQbPAemDijpnGJ0mtanxI1RjWeFFLVsGMsPU05zE8X1ln1XW/LQYt
 4p84qW8tjYLiOSabXHvIIu1FWh/6fFkRqPN12Ip9MSMi0hMJV91+laD2VbvYA3h85h38
 9la+7uJzKuYHSmUvmiLNGQqfdOq7lnp8/FIvhO26OAYJIka/xjXnadLfhQQzLtXg4KC9
 a2rkje+U+gPLfVo6q+Od6XeNyAB0Y//OoVvYeGca4KSJTQXz9IyHhCql5TJpl2AUZ1WL
 MlkzUYPsxaPur3yEOsfYviFjamP/AqrlSnwPk3TRqurXthzUa7tElNkZo3YDBBj9akNc
 0KmQ==
X-Gm-Message-State: AOJu0YzId1CDmFNwx3dtrS696QqV9+b+rQMagDpxPzTYbeaOIOFE+CwS
 rVuxhL0nErQshbfWmwEDPc/JoLaCKCjkpl4RlV0jyj2U8N+rVgCvBwL7msNOZis=
X-Google-Smtp-Source: AGHT+IHMprkau44Qe3lFKQrt/13mkFPfzfcO0cjJA2aZFWBVL3kgVYar/XjBSEoCPGmmrtjU5kfiyQ==
X-Received: by 2002:a5d:64ca:0:b0:343:a2fb:92aa with SMTP id
 f10-20020a5d64ca000000b00343a2fb92aamr1108402wri.71.1712158713865; 
 Wed, 03 Apr 2024 08:38:33 -0700 (PDT)
Received: from perard.uk.xensource.com (default-46-102-197-194.interdsl.co.uk.
 [46.102.197.194]) by smtp.gmail.com with ESMTPSA id
 q4-20020adfab04000000b00343a3e62997sm991281wrc.50.2024.04.03.08.38.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Apr 2024 08:38:33 -0700 (PDT)
Date: Wed, 3 Apr 2024 16:38:32 +0100
From: Anthony PERARD <anthony.perard@cloud.com>
To: Marek =?iso-8859-1?Q?Marczykowski-G=F3recki?=
 <marmarek@invisiblethingslab.com>
Cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>,
 Paul Durrant <paul@xen.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH v3 1/2] hw/xen: detect when running inside stubdomain
Message-ID: <ec141587-4d49-403b-b773-26b9087d5b04@perard>
References: <cover.527f002866de2be7c275c5000b6e5edfeb7e8368.1711506237.git-series.marmarek@invisiblethingslab.com>
 <e66aa97dca5120f22e015c19710b2ff04f525720.1711506237.git-series.marmarek@invisiblethingslab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e66aa97dca5120f22e015c19710b2ff04f525720.1711506237.git-series.marmarek@invisiblethingslab.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=anthony.perard@cloud.com; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Mar 27, 2024 at 04:05:14AM +0100, Marek Marczykowski-Górecki wrote:
> Introduce global xen_is_stubdomain variable when qemu is running inside
> a stubdomain instead of dom0. This will be relevant for subsequent
> patches, as few things like accessing PCI config space need to be done
> differently.
> 
> Signed-off-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>

Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>

Thanks,


-- 
Anthony PERARD

