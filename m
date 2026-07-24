Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0543CC531FA
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 07:37:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnATU-0002h5-JB; Fri, 24 Jul 2026 03:37:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wnATT-0002gT-NP
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 03:37:39 -0400
Received: from mail-pj2-x03.google.com ([2607:f8b0:4864:39::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wnATS-0003fG-1K
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 03:37:39 -0400
Received: by mail-pj2-x03.google.com with SMTP id
 d9443c01a7336-2ccb0e85312so895215ad.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 00:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784878656; x=1785483456; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zFMb2YBdmcuvyXawc9pfFblYfSXeyffS1TwMgRRoJ78=;
 b=YZSVGY4QnkP4kjd4Vf9xaJTYJU8LGGudVv/AzZWnQgUqkJz/Radtd8TzROWeR1JIhP
 RSvd6yhwPtG/D8RVxmjUyJr6aM2KPL8ySIaxQYmg2sklPmqoGsyM3fCWW5en8d9bXm/6
 +58iIEwbzIf/4aIkv2q51Xx8lKPC5AUQ/vkPYtQhZRKYWeMki/SLMJF5M2PgCdmoArC+
 efAWxtGujKb7q1XeRlgrcZRa8cXm2ygJGtVHojljkmv9n4dgag31ReZVNXOI04ivAeXK
 e5s+k3KRiPzli6wDdlb+TmRZA9DNhQ+A3Qy08zZ2tfsonemrujYZUJtEJgY03M+7ZObH
 RZZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784878656; x=1785483456;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zFMb2YBdmcuvyXawc9pfFblYfSXeyffS1TwMgRRoJ78=;
 b=gRiUGsYIAwkmgLE81w/KQp+J50f3d/vI9Uo5Ze4ynxPOWMJs9X/DC4U2QNHeyW+mVE
 0RPKFRgZOSPBOyMk9sZADKapLW0oDFciiC9a8aVQF5Zlwkf0gKVC8auPyeqFn2pN/TVr
 jgBCutUCEg7jcCs664z1Su0FfHkXRDGZDzDeinwkfvVFPAZL2i+E9MokV9l2Zn5qj+Ea
 qaorhQhSEFbNlRRY1QxEh99wlZd5YAco26Vqh5r1MkO3sijZgKAH3kGWItjSHJQuR0Fc
 t4SojuZO2uapWsDt54SxoNZPzkJbn5vWDfcXiM/lZwh9PxdYrbez3zVZdrDFP8A4gLrU
 PgmA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpZ2LRuxj+CNjZ+ujNpUBSecN4YczprwCTP+p86ThnH+mcNGlx4NG4J0nIdzaAm8S2dlNw6OLpMoKJo@nongnu.org
X-Gm-Message-State: AOJu0YzTRnA/O36RQVuCMOCTLyg8Cx/7KeU4JI8R+0mh2YwZKfyIdnuM
 Gf8ZMneNEssgGKxzAQ0C6yYJMK6bVAZgE06kLncvZCldImYDrm4q02M=
X-Gm-Gg: AR+sD13aHyVI1Z2239gItRc9uwrDCKPTpwMh4jM5dxDyGcKrBob/l4LQKUHTby3HNCE
 /5U+nWPEsVU3uEL7owRu+BuNMM05G2wZRKZtPk+y4hC/D02fhiqWkQIOxuJKula3dd57kNChTDk
 u2lkgo21eeIpIU7LEBcliwGpkoSvu1H5h7HkCSJ6k7QEP83lm4/V33OwBX1BCVqb0/BM6+xpE3v
 SVk0me5sZxOFo01irpmJYbeBfDFAtdxeIcq4Sz2EOjRMqlcV62nLzfc6DWC4qF+UtGWqATmyLJd
 7+vCv7ZKQMm83rQI4Vili9KR8oun2TyaMGgpJ9H6BfxWlP+bSpYZYqqfESYqXcouG/fLThQoEVp
 RstauDFTpeUxKKkJbiiO0tTRO7Ji4zlSkR8JwH9N93lB4UhqsXUq/cLgeU5rwAsWqo32/QUQLew
 kZrAhO5Z4ku9wMknvN5g3oC4Ux8tS1/f8yBOUIpeYkdStpxPwox6EwBnpOaRn23UzUMbLO
X-Received: by 2002:a05:6a21:730a:b0:398:7ed3:a001 with SMTP id
 adf61e73a8af0-3c44afb1ab6mr6860041637.2.1784878655983; 
 Fri, 24 Jul 2026 00:37:35 -0700 (PDT)
Received: from ?IPV6:2408:820c:8ffa:c0f0:e439:d3f2:d7e2:d97a?
 ([2408:820c:8ffa:c0f0:e439:d3f2:d7e2:d97a])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147dc1a6adsm26210399eec.6.2026.07.24.00.37.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jul 2026 00:37:35 -0700 (PDT)
Message-ID: <20027e4f-5a4d-4842-a60d-cd83a5755cff@gmail.com>
Date: Fri, 24 Jul 2026 15:37:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/igd: sanitize DBUF_CTL POWER_STATE for iGPU
 passthrough
To: mike.malyshev@gmail.com, qemu-devel@nongnu.org, alex@shazbot.org
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 =?UTF-8?Q?Corvin_K=C3=B6hne?= <corvin.koehne@gmail.com>
References: <20260717084942.1555442-1-mike.malyshev@gmail.com>
 <e7b38b86-fde1-400d-ae5f-5b2ad0b4cb6e@gmail.com>
 <20260723174147.479506-1-mike.malyshev@gmail.com>
From: Tomita Moeko <tomitamoeko@gmail.com>
In-Reply-To: <20260723174147.479506-1-mike.malyshev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::3;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pj2-x03.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NEW_PRODUCTS=1.249, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi, Mike

On 2026-07-24 01:41, mike.malyshev@gmail.com wrote:
> From: Mikhail Malyshev <mike.malyshev@gmail.com>
> 
> Hi Moeko,
> 
> Thanks for the review.
> 
>> Just wondering if this aimed to solve some kind of "CPU pipe A FIFO
>> underrun" error. If possible, could you please paste some log? The i915
>> driver seems to only read POWER_STATE in gen9_dbuf_slice_set(), and a
>> warning should be printed if there is an inconsisitency.
> 
> Worth clarifying up front: the guest here is Windows (Intel KMD), not
> Linux/i915, so there is no i915 dmesg or gen9_dbuf_slice_set() WARN to
> paste. The visible symptom is corrupted scanout (~128px vertical stripes)
> from a plane FIFO underrun, not a logged kernel error. I have not run a
> Linux/i915 guest on this platform, so I can't show it hitting or not
> hitting the bug -- and per your point about the WARN, i915 may well flag
> or avoid it, which is consistent with us only observing this on Windows.
> 
> The trigger is a single inconsistent read on the first-boot modeset.
> Captured with x-no-mmap=on so BAR0 is trapped and every access is visible,
> the DBUF_CTL programming is a read-modify-write that never sets
> POWER_REQUEST:
> 
>   vfio_region_read  index=0x0 addr=0x45008 data=0x4040c000  # STATE(30)=1, REQUEST(31)=0 (stale POST leftover)
>   vfio_region_write index=0x0 addr=0x45008 data=0x4043c000  # RMW: tracker bits only; REQUEST still 0
>   vfio_region_read  index=0x0 addr=0x45008 data=0x0043c000  # DBUF now powered down (STATE=0) -> underrun
> 
> The driver sees STATE=1, assumes the slice is already powered, and leaves
> REQUEST clear. Only after a display sleep/wake does it actually request
> power, which is exactly why sleep/wake "repairs" the display:
> 
>   vfio_region_write index=0x0 addr=0x45008 data=0x8043c000  # REQUEST=1
>   vfio_region_read  index=0x0 addr=0x45008 data=0xc043c000  # STATE follows -> powered, scanout clean
> 
> Same pattern on 0x44fe8/0x44300/0x44304. This was originally reproduced,
> and the fix hardware-validated, on QEMU 9.1; this patch is the forward-port
> to current master.
> 
>
> I'm happy to share the full trace event log (~400 MB) -- where would you
> prefer it? I can drop it on Google Drive and link it here if that's
> acceptable, or attach a trimmed excerpt inline.


Got it! I think the lines above here are enough to pinpoint what actually
went wrong. It would be helpful if you could put the above explaination in
the commit message of v2.

>> Here GVT means the GVT-g (kvmgt) driver under drivers/gpu/drm/i915/gvt,
>> right? Please correct me if I am wrong.
> 
> Yes, GVT-g (kvmgt). It emulates STATE-follows-REQUEST for this class of
> inconsistency; this quirk is the read-side equivalent for full passthrough.
> 
>> IGDDbufCtlQuirk *dq = g_malloc0(sizeof(*dq));
>> dquirk->data = dq;
>> would have better readability.
>>
>> A `vfio_quirk_alloc(nslices)` might also be better here?
> 
> Both make sense -- I'll split the allocation and use a single
> vfio_quirk_alloc(nslices) with one mem[] entry per slice.
> 
> Let me know if the patch looks acceptable in general and I'll proceed with
> a v2 folding in the above.
> 
> Thanks,
> Mike

This definitely looks great! Thank you for your contribution!

Moeko



