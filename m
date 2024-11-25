Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF75D58D71
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 17:52:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFdG7-0001Kd-FT; Mon, 25 Nov 2024 12:52:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tFdG5-0001Ie-O6
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 12:52:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tFdG4-0001sS-Bu
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 12:52:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732557143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yLtLe87azHvt7N42GxKEtuNK9Y9P6nfdtq4AEWorpiA=;
 b=BJkVqJSVsB3AqrOamQOrfbL0Qn2AVnTtEpQ5/jE9LYo/vsnTyfQgWfToR9C6RNUSNAmfa9
 fs1CG9/Kh/rHlKlGGj7nuz3U3Z8WFQiD56qW13Z76uiadWT3k1KxsNRzNlxa5zq99O8PVY
 dObexcA7VYISsFAmrIs5E6O/TCkyRyc=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-bM1OSFULOBatWsajy_Zfkg-1; Mon, 25 Nov 2024 12:52:21 -0500
X-MC-Unique: bM1OSFULOBatWsajy_Zfkg-1
X-Mimecast-MFC-AGG-ID: bM1OSFULOBatWsajy_Zfkg
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-8419f8859f7so95916939f.2
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 09:52:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732557141; x=1733161941;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yLtLe87azHvt7N42GxKEtuNK9Y9P6nfdtq4AEWorpiA=;
 b=vT2PjGJ8dM9gxf2piHibRPItGAmJ1xyG+8jnb2ZgDwdUijFNC6yilZyUl8GGfssFEh
 /KR7Ph/iqPbiaaFbOQu+5Uc847vN/snljIzpDuAqLaj087HnfctlGtaTaqa+kdXaEa59
 tAl0VM9njU7yNnWIcN0SXJZPfh69QPNEOLWDEQESY5Jkw65GijJJ8TZgfE5gUzvI+1Yu
 yI3z8E4zYDvUuD3+F0KVwddToYE3/66c0aor7SVjPj26PUYbJPXEZkawcZUhEokkGobz
 cB/ncuiP7CTLrUWoo7ggjL968BQ/qQkLhd35kncV9OZsXqwEmQ+1QilLanwYXgkfXSP/
 9vYg==
X-Gm-Message-State: AOJu0YxUFjAsuXxg0/THXzeicoQh785G5/3xzmDMcMA1Vzo/bvNta4qt
 Wm6q0ciK79NVgS4SvSgkpxJKNmEsK3rpWVJcUOGLxRjhYVQ1kCI5XBHjNHBWU18QrF2/O8uRS1u
 rYqPmA8N17bhVaGG7jL5smDPG9cEBRdfLM0w5ZxrlMxBVCo+9KdEj
X-Gm-Gg: ASbGncsC9I0bVkdw35OPPIb7xYvWfHyF5adqUTsiG5TNYbbPOtVsjf69+094+ELuo2s
 RTo5v7IN745qGY7rtAnOlaBnHPEGPBIFIaFylHEg7Yphv77oeAXTkJ2+Na8OVChS5Y951QxOBCp
 wv/CHHVfSDSpZ0xSaAxylsTBmKnLjJfLbR/5ZIbotXR9AvZZ6HY7iC4jSwNmm3kKw/o6nj+CKHh
 SCCE0pAwDsiDYxU9ozC2wqHEVfHU/A9iNGtpJYxqQiJY4HFJrDX1BLZRvTR9yrJOBIbx0nljx7g
 PWkt9KPOSkE=
X-Received: by 2002:a05:6602:490:b0:82c:d768:aa4d with SMTP id
 ca18e2360f4ac-83ecdc97029mr1480007739f.9.1732557141042; 
 Mon, 25 Nov 2024 09:52:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKAUjkUu5ipk7hYCmnE9Pfl60NYF3Xepvu4P16h5GeAPBrgZhtiBt2Sc7Wt5bg4lxtY/XytQ==
X-Received: by 2002:a05:6602:490:b0:82c:d768:aa4d with SMTP id
 ca18e2360f4ac-83ecdc97029mr1480006239f.9.1732557140790; 
 Mon, 25 Nov 2024 09:52:20 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83ecd418010sm186580139f.42.2024.11.25.09.52.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 09:52:20 -0800 (PST)
Date: Mon, 25 Nov 2024 12:52:18 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 15/22] tests/qtest/migration: Split file tests
Message-ID: <Z0S5UthCGNfYeWjx@x1n>
References: <20241113194630.3385-1-farosas@suse.de>
 <20241113194630.3385-16-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241113194630.3385-16-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Nov 13, 2024 at 04:46:23PM -0300, Fabiano Rosas wrote:
> Split the file tests from migration-test.c. These are being moved to
> their own file due to being special enough compared with the regular
> stream migration. There is also the entire mapped-ram feature which
> depends on file migration.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


