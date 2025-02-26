Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CDBEC021BF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 13:42:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnHfz-0002RW-MR; Wed, 26 Feb 2025 08:42:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tnHfy-0002RI-5p
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 08:42:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tnHfu-00030N-Ts
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 08:42:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740577329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6r1Wq596QNoNvSBt6dcLce0L5ycBOefeiOcjAHTd8A8=;
 b=WnTucFxI76kD8if0wWNqibBE1PhYX68AW9LnP3DFQPZ9dXFBtoKUmd5RHlXDYKttY0V03s
 RI6VNxH098Plt7i0W1CPb/HRlrLUc5OpRHzQOJAgNtf4VMZVbL41jM+wdqQnyVbhJB78DW
 ki47gUZgO4AudRLfBYBDWAG/1juh3rI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-3vtaeaEcM6iwxUriUCE5vw-1; Wed, 26 Feb 2025 08:42:08 -0500
X-MC-Unique: 3vtaeaEcM6iwxUriUCE5vw-1
X-Mimecast-MFC-AGG-ID: 3vtaeaEcM6iwxUriUCE5vw_1740577327
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4398e841963so52117015e9.3
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 05:42:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740577327; x=1741182127;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6r1Wq596QNoNvSBt6dcLce0L5ycBOefeiOcjAHTd8A8=;
 b=geJBh2OOZ7KeR2udkNwh34VUtdSTOot7uEbxvQRp48FViu4O2qpprpidsnsvIZZTZ7
 0XaYDw3kfGwaSnBYlbmYXIPEFUmTbCgJyAWj+LPg2TmBKmYKMqFLcbxVCdHEaCzo9mSX
 6NwD1JX1a2cpCa7KdBK361XnkOysYVEYgx2YNRX8+Mo6JwmYFpQq1Ngr8hWHvwIf4I4Y
 5/u8gOvmigFftn34IyFzTKRp42SkqiwEUBkLQ03jJlD8R3q6UpBX/qym7JCrv0oezI2H
 EJkoULQ6iNVIpm9snc19noD7RPk+mGakoLskRRGrl4GrUzkJfx3/8QHcnCwCpt8dZeU/
 OXfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbw4BuHrMJcwiRZC8/yyhnAz2pXXhZ/+uwaADb3OGP80/1eKcWp5WCNRYHw8geV6u97XyYIuDnDoTq@nongnu.org
X-Gm-Message-State: AOJu0YxevHvny5thLvjPX2K4Y+TaNlk7EKb7AYAnlHNgWB7yWUpFQYCE
 ARhVn8B31LQtBKj2bVZQSnbeSabsG1/7129na5qSixfkpCTmJ7cIVerX9eQXbULbtArOPwyKCUs
 l7MXuCytP6N+Ey+DrRD0vpUH3NBTMAhtU5htNp8e58C+bB1C4ceom
X-Gm-Gg: ASbGncsuELoskV7rVzQhUux0I44m6t9IUX091oJav+syqhl/ljLNRehyLH4bYIBCZkW
 6Eesovvv4gb6wK/Hq6SsjiaoP7at7mRqXzd3D/q5ndNiSrlVzRhh593Q4W+qV5P81aGaYVmgN7z
 WdZsAr53/mSYB+HQUqaqPrxW0A/mrfaPoLwtzD6l4eXz0EZjwLjqAzEfkbV5oswROhs5Y1QOMBP
 loGJG1i9hc/2dBQrvCIFmorSykIvU/3JOW5NJ4Af/GEvhcR9k9w1KUQdJNhLQU9RBxFJM87HjfL
 ZVkLSPmnve02QbNf6JQMETbKHQuHIyi75ilpbZdcoUO7XJx9yS8CSulhZKwCl+Y=
X-Received: by 2002:a05:600c:4fc2:b0:439:9828:c446 with SMTP id
 5b1f17b1804b1-439aeb0f1ebmr197895715e9.11.1740577327151; 
 Wed, 26 Feb 2025 05:42:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFpdBc99+UN2rjxWw8jbmo7+NslkMhLGp65yLKvda0c80Hx2R3Y0c06sY2//F/liP812gtl3A==
X-Received: by 2002:a05:600c:4fc2:b0:439:9828:c446 with SMTP id
 5b1f17b1804b1-439aeb0f1ebmr197895475e9.11.1740577326748; 
 Wed, 26 Feb 2025 05:42:06 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390cd866f0asm5660373f8f.12.2025.02.26.05.42.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 05:42:06 -0800 (PST)
Date: Wed, 26 Feb 2025 14:42:05 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>, Nicholas
 Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org, Zhao Liu
 <zhao1.liu@intel.com>
Subject: Re: [PATCH 4/4] tcg:tlb: use tcg_debug_assert() in
 assert_cpu_is_self()
Message-ID: <20250226144205.22eeccd2@imammedo.users.ipa.redhat.com>
In-Reply-To: <07c147b4-67e0-4dd6-8ce1-9badf5706e42@linaro.org>
References: <20250225184628.3590671-1-alex.bennee@linaro.org>
 <20250225184628.3590671-5-alex.bennee@linaro.org>
 <c7c2d873-3ea7-41a5-8842-1ebf33b5a560@linaro.org>
 <07c147b4-67e0-4dd6-8ce1-9badf5706e42@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, 25 Feb 2025 12:04:40 -0800
Richard Henderson <richard.henderson@linaro.org> wrote:

> On 2/25/25 12:02, Richard Henderson wrote:
> > Not checked here are any of the other reasons a flush might be ok:
> > 
> > (2) The system as a whole is stopped, on the way in from migration/vmload.
> > (3) The cpu is offline, on the way in from poweroff/reset.  
> (4) Running in round-robin mode, so there is *never* a race between cpus.
> 
> Anything else I've forgotten?

looking at x86 reset path
 * we have 2 resets per vcpu from main loop,
   when vcpu is created (at realize time and at system_reset time).
   this probably are nop for tcg as you said.
   (it likely applies to all targets)

 * And also a reset triggered by IPI (run in vcpu thread),
   which likely should do flush to clear whatever context
   vcpu had before reset.



