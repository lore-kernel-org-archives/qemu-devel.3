Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56072CC6B3A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 11:22:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHJWr-0002jV-4Q; Thu, 15 Oct 2026 07:21:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xHJWh-0002ZT-DX
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 07:21:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xHJWf-00046O-UX
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 07:21:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792063293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Z+Qg4+Boh/WsVIjpWWvTlFbpkcpMtdY1fVfSGUlvkzI=;
 b=bba+0nBCH6gfreYmqZwboL1lLxD+GCSuIcMrFgYqtTLM5VgLog3bUfMcQUHZhNDdxd+wnE
 dMu283WJ1DFBYLn+zdsmgnApuP/uGaEBjHB0QeNxyTDpy8DJHX5kSJz5LfgdmI2AloYUQl
 4BInTj+1Q9dN8gxYhoWrhQb5vQVwP0A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-Dx6fYTf9MXS8BiyocCJhPQ-1; Thu, 15 Oct 2026 11:21:25 +0000
X-MC-Unique: Dx6fYTf9MXS8BiyocCJhPQ-1
X-Mimecast-MFC-AGG-ID: Dx6fYTf9MXS8BiyocCJhPQ_1792063285
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-48c415561aaso3272209f8f.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 04:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792063285; x=1792668085; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Z+Qg4+Boh/WsVIjpWWvTlFbpkcpMtdY1fVfSGUlvkzI=;
 b=itw9ZFpnlPQwYRZmgfeBeQl3Oqw1rIE3c30IWYMgQ2hYgTl0tRQWcsEgRC+Yx2k53Y
 KF4pkCvFebBzE/3j8Nw/EYmu9BMbzMCrc4Zt8r/1ztJly3zZ5MG1W3YonJTm6CHxOkUJ
 m7EHazmQ7n3obKvze+va6asD0W3HVNB1hhMyru4mD/CL6bk+5ZaRm+v6KgcpvO2uGpGd
 BPqIa+84O0nPDc99T3bsHBvnkRcrTwuuDe+4QYCHKx64hfbiNsrYfC+RMIjTH4p04WwB
 8mii6cFDQRhP3dO4N6/TBnmsMmMqBhZyr8kPrOC+REgLitgkW9uJLi6MUbW/gmGdFc/N
 XiGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792063285; x=1792668085;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Z+Qg4+Boh/WsVIjpWWvTlFbpkcpMtdY1fVfSGUlvkzI=;
 b=A7ASnisaZKx0DVirmT/P1Dmwz7SflUWhTrsmG0ZrhalcjRzJRoUkauHJu3NJ2sU2G2
 yp+yxhBhGw260DIs8fh4bZfu4VpIWOxE+axDQ2Q+tNRD8ObF4GSZ7sIJ1prgyNfjsPgM
 cQ59+4mOAKaNK7e1KgXKrq3ZOHmxFp9OZH04XUUUESZXtgY1w9hrmMGn28kioSfca0gB
 u37DHhn8Em5Rgt5pHqRJGgpNvMVMO/AjqSt8HuHhisf+hKFAUqJMy47vefD0b3judAyb
 8eobH6VbqDwQOUdE2+3euQPY3nBnhEAJ1+F9uN00vqXfKM9M0ZO12xQXy6+lOGWLSqqt
 Q09A==
X-Gm-Message-State: AFq9FYI4B+RzkJX2dCfQDjnFhLnqPsu0E/5vXb0arhtdUO2bd6Z9onzP
 6b0WT7uaLEm/kYNcbsFdhfhtUd1OeXbYchN/XPt1DDZxYHZ5kYStKA+j2sDLvPRgakBnMbYVMrs
 JAAbWBoE8ciwCA2lJTN/fns987u8lUfM+MVeBBHKVamysjUn9OuVLlCIMasZELBzOfSOWESoz4R
 pURknbt+AVMAy4hsz1hf3/XWCtpKi8otitMg==
X-Gm-Gg: AYBFou2p+JU8ctRjQX7VFfuHAaNBZYpTSqM3ZgBsa7COubkEFExkb/HNQ5OQhlaNDkH
 8PbOJ8s4A0Bjk4ErJGLsH38LAoNUM6zMAaIhs+vKKg2WIFyyZ/dUUXKoyQlDDrf6jMijFnLvRNt
 XIQ6PQm/pdZlSgbw98f4fyyfDS8/9EU/PBE36KhCENo+cQ6AmvYOtudqBU6NtZjG6iJUiCWrqbw
 weqs+IVBwg3bz0Ym67qEq9PoaL0dbUU6bCno+9upIcX1ptu6RgX4YSbfPBHFTef+EHPfm9KppD2
 BaqujlR2TEOyMu4hl+3BjOGhcjvrmLCr+Ecg1i7IwuBIDPQzaHl+cw01o38nxqD3vIUsIVNUNyl
 6gc4xYsSV+AsaCApdoJ2+lqHEO6njwLyt2Pz9UHpl
X-Received: by 2002:a05:6000:2002:b0:487:a15:b4cc with SMTP id
 ffacd0b85a97d-48dbaaea8c0mr33664443f8f.23.1792063284710; 
 Thu, 15 Oct 2026 04:21:24 -0700 (PDT)
X-Received: by 2002:a05:6000:2002:b0:487:a15:b4cc with SMTP id
 ffacd0b85a97d-48dbaaea8c0mr33664404f8f.23.1792063284234; 
 Thu, 15 Oct 2026 04:21:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:1292:d530:578a:3c67:6721:1232?
 ([2a01:e0a:1292:d530:578a:3c67:6721:1232])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0bd1843sm18324510f8f.56.2026.10.15.04.21.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 04:21:23 -0700 (PDT)
Message-ID: <3d025f7f-7dfb-4460-9d0f-aea66b36b646@redhat.com>
Date: Thu, 15 Oct 2026 13:21:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386/kvm: Fix UBSAN shift error in MTRR mask
 computation
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
References: <20260722120437.697986-1-clg@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260722120437.697986-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/22/26 14:04, Cédric Le Goater wrote:
> On AMD EPYC processors, raw CPUID leaf 0x80000008 reports 52 physical
> address bits. When a machine type such as microvm forces
> host_phys_bits=true, the CPU ends up with phys_bits=52, causing
> MAKE_64BIT_MASK(52, 0) to shift by 64 — which is undefined behavior.
> 
> Fix by only computing the mask when phys_bits < 52.
> 
> Fixes: fcc35e7ccaed ("target-i386: Fill high bits of mtrr mask")
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   target/i386/kvm/kvm.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 4272b6770c7c9e3907a8f4de2c3234378f16482e..6dd314c90748e49b1ff27933b208dc552dd58906 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -5064,8 +5064,7 @@ static int kvm_get_msrs(X86CPU *cpu)
>        * we're migrating to.
>        */
>   
> -    if (cpu->fill_mtrr_mask) {
> -        assert(cpu->phys_bits <= 52);
> +    if (cpu->fill_mtrr_mask && cpu->phys_bits < 52) {
>           mtrr_top_bits = MAKE_64BIT_MASK(cpu->phys_bits, 52 - cpu->phys_bits);
>       } else {
>           mtrr_top_bits = 0;

Applied to

     https://github.com/legoater/qemu vfio-next

Thanks,

C.


