Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48BE4C3600C
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 00:12:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzPDs-00012B-Uw; Mon, 31 Mar 2025 20:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1tzPDr-00011w-6O
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 20:11:19 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1tzPDo-0005yI-G8
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 20:11:18 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-2c75830b455so3124866fac.1
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 17:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1743466274; x=1744071074;
 darn=nongnu.org; 
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1JHjpPUXr7aA1/5+zCX/Huu7V2gAc+XOvRVSFJASN+w=;
 b=evsoTt8gWCuNga9d+ZE7GbOoVTEQ7LaKtCEje4b8rqiMgLGJ/TWg6XA0HfFKFJm/sE
 /scpPWvRNVDd0CySQyiaa8XyCMq00INFCY9tgtt/6CbaXNHKzXbcxRlRVuhhB1dK05Yb
 Odb+m7RvEbJL/6rfRGQAgaQXgIvmT405b/Un0qhymbLx1/P++UUfyRx8ZrWoKA6rcl4p
 wcWP2wGG2j3DAna6bB9CQYI0L50Rbf6x2JI1GS8+k6Qc/eudqUk4DUSYz7QkxVM6ZQtU
 xvmWW5mk6S2X5efL6VzvlJYDgeOzL0FJYaaRwhq44xhbazf8SGp/hYWX2NBYloN0nRTI
 HSGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743466274; x=1744071074;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1JHjpPUXr7aA1/5+zCX/Huu7V2gAc+XOvRVSFJASN+w=;
 b=eJixlaMOEmWIT1kOogeFmV6VsCbKP7wicAd41RAT50S2Jr+ejOPAop1olY4XU3IbPw
 nddNy0g7sM/wnlMZjQsZuLLQiWGRqYs6ODB4V4UYU7NCl57hzfVw0M62+VETSXFv8V6P
 khvesV3dqGpfDXhHEMgNu00MapCL/hW8XVetM1h1bQ/2N+b1oxIabslg1PwSOhuuqql/
 l/2luLefLUzx+hgmxUJJ7rblZGqfsVfQmdVSfiIH+t8utGsDUBFfVUjWZqTtguHCSGmn
 8LXIQyD8IFovr2I4BRL6CIYbPz6XvSqw8M9650U5BZ1NBSKM3ksTBIVUbd9gXnEArZj9
 Gtpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVecaScf50NBEeGE4AlNqzuheCPrxRE9rskzsuSl/s9L/quLO2riGUe0r96QKlcxJH0jfrGCiewZp6/@nongnu.org
X-Gm-Message-State: AOJu0Ywakoxa2P1j3qWmRWQCsHdHHmAoezFkS9UWyTNXLAexbIa1mpV0
 JXPfnjiwqRywLDRDg8HFXhlIoRowapXxfgDXR0O2vsqUg9+yCrzwFId1mDHRfcI=
X-Gm-Gg: ASbGncsRqQhdkXYrqL2XE+u/2cN5g+I8WbVAgZXst8q4G5MRG0RGRcwCK8itizZxZHu
 ulXz15Hk8hmcu68kSOiN0ADNkcojkL54WL56/mFs13+bYqkOcTv65aNzMorIU049UjtAF01Jviy
 OwJBzPTgqx5naO0Ygpj5YACTxyQ8zmFffjtswjYHf4URl8G1noKQ2eq3D8PMzD7h1ZaV/LLxWYv
 xAKDY52wbiCUu7AT7dwVhcoXBtsc5oHefywOXOM1J641dpim1NZxC6wVg7OwHq78ZALvbBxpqaG
 TBEZs6olp2lE4wpwBaf/vET7jKPVpMupT5w5piq6+VCQTj+C
X-Google-Smtp-Source: AGHT+IEGQoywBsRIh7YdIC3vSEGo5wptR5e/+LirXAHcebh+GXJ30YVX/26Seg2PwjgU3Scf7YsNhQ==
X-Received: by 2002:a05:6871:a00a:b0:2c2:3eb4:e53 with SMTP id
 586e51a60fabf-2cc382d1e2fmr573969fac.37.1743466274244; 
 Mon, 31 Mar 2025 17:11:14 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:8459:d76b:f4fb:8568])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72c580d32e3sm1674137a34.34.2025.03.31.17.11.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 17:11:12 -0700 (PDT)
Date: Mon, 31 Mar 2025 19:11:06 -0500
From: Corey Minyard <corey@minyard.net>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Corey Minyard <minyard@acm.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH 3/3] ipmi/bmc-sim: Add 'Get Channel Info' command
Message-ID: <Z-svGoCWnvYz3Shj@mail.minyard.net>
References: <20250331125724.607355-1-npiggin@gmail.com>
 <20250331125724.607355-4-npiggin@gmail.com>
 <Z-qX2R9o-kpby24z@mail.minyard.net>
 <D8UULC4ZS27K.2JYUFGLKD5Q8Q@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D8UULC4ZS27K.2JYUFGLKD5Q8Q@gmail.com>
Received-SPF: none client-ip=2001:4860:4864:20::2a;
 envelope-from=corey@minyard.net; helo=mail-oa1-x2a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Reply-To: corey@minyard.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Apr 01, 2025 at 09:42:01AM +1000, Nicholas Piggin wrote:
> On Mon Mar 31, 2025 at 11:25 PM AEST, Corey Minyard wrote:
> > On Mon, Mar 31, 2025 at 10:57:24PM +1000, Nicholas Piggin wrote:
> >> +static void get_channel_info(IPMIBmcSim *ibs,
> >> +                             uint8_t *cmd, unsigned int cmd_len,
> >> +                             RspBuffer *rsp)
> >> +{
> >> +    IPMIInterface *s = ibs->parent.intf;
> >> +    IPMIInterfaceClass *k = IPMI_INTERFACE_GET_CLASS(s);
> >> +    uint8_t ch = cmd[1] & 0x0f;
> >> +
> >> +    /* Only define channel 0h (IPMB) and Fh (system interface) */
> >> +
> >> +    if (ch == 0x0e) { /* "This channel" */
> >> +        ch = IPMI_CHANNEL_SYSTEM;
> >> +    }
> >> +    rsp_buffer_push(rsp, ch);
> >> +
> >> +    if (ch != IPMI_CHANNEL_IPMB && ch != IPMI_CHANNEL_SYSTEM) {
> >> +        /* Not supported */
> >
> > I think that an all zero response is a valid response.  I think you
> > should return a IPMI_CC_INVALID_DATA_FIELD instead, right?
> 
> I can't remember, I dug the patch out from a while ago. I can't actually
> see anywhere it is made clear in the spec, do you? I agree an invalid
> error sounds better. I'll try to see how ipmi tools handles it.

I'm fairly sure an error response is ok.  Please pursue that.

> 
> >> +        int i;
> >> +        for (i = 0; i < 8; i++) {
> >> +            rsp_buffer_push(rsp, 0x00);
> >> +        }
> >> +        return;
> >> +    }
> >> +
> >> +    if (ch == IPMI_CHANNEL_IPMB) {
> >> +        rsp_buffer_push(rsp, IPMI_CH_MEDIUM_IPMB);
> >> +        rsp_buffer_push(rsp, IPMI_CH_PROTOCOL_IPMB);
> >> +    } else { /* IPMI_CHANNEL_SYSTEM */
> >> +        rsp_buffer_push(rsp, IPMI_CH_MEDIUM_SYSTEM);
> >> +        rsp_buffer_push(rsp, k->protocol);
> >> +    }
> >> +
> >> +    rsp_buffer_push(rsp, 0x00); /* Session-less */
> >> +
> >> +    /* IPMI Vendor ID */
> >> +    rsp_buffer_push(rsp, 0xf2);
> >> +    rsp_buffer_push(rsp, 0x1b);
> >> +    rsp_buffer_push(rsp, 0x00);
> >
> > Where does this come from?
> 
> IPMI spec Get Channel Info Command, search "IPMI Enterprise Number"
> From my reading, all channel info responses contain this.

Oh, sorry, I should have read on this.  This is fine.

> 
> >> +
> >> +    if (ch == IPMI_CHANNEL_SYSTEM) {
> >> +        /* IRQ assigned by ACPI/PnP (XXX?) */
> >> +        rsp_buffer_push(rsp, 0x60);
> >> +        rsp_buffer_push(rsp, 0x60);
> >
> > The interrupt should be available.  For the isa versions there is a
> > get_fwinfo function pointer that you can fetch this with.  For PCI it's
> > more complicated, unfortunately.
> 
> These are for the two interrupts. QEMU seems to tie both to the
> same line, I guess that's okay?

Yes, they are the same.

> 
> That interface looks good, but what I was concerned about is whether
> that implies the irq is hard coded or whether the platform can assign
> it, does it mean unassigned? I don't know a lot about irq routing or
> what IPMI clients would use it for.

For isa-based devices, it's hard-coded by the configuration.  That one
should be easy to get.

For PCI, I'm not so sure.  It would take some research to figure it out.

> 
> Anyhow I'll respin with changes.

Thanks,

-corey

> 
> Thanks,
> Nick

