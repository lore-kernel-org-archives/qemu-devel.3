Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A130CC02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 17:56:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thY08-0002br-NP; Mon, 10 Feb 2025 12:55:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thY07-0002bU-7x
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 12:55:19 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thY05-0005mk-Gq
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 12:55:18 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-21f49837d36so52138585ad.3
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 09:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739210116; x=1739814916; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DkdEH6sUVSYdCOe90izcf7TmjmouF03Sb+YzoMm2llg=;
 b=eG0SUy4B/ySzvGFtG4fVZ5p9ZnhCFPPBqV76m1n9I2e1D2hzOBXfNJIJE/Ugj+nEyv
 bgeDK4ayGm2e8z7T0p/OCifa781zf+YUnYPdr7wY+wjVC98biY2BONPGoE7E5xiQz9Zh
 O7KW9QIIcHuInO348YLv1u6tWfzULA1Wptjvx90YxHV1u77qr6+S20beahjnOh3ClraD
 wMuOoOMmvsdqO0g8fa1enoC4TNcc3WW+IWBHnf5YUiWaZ/YFDb42EIhS3I8eJW/F/fDL
 tYb2uNrJ/5vI+qDA9tr3hPR1bCOjyI+Kxwyu/Fwz2owkCTb5C+EQsOFAAyvZNRsxCN0V
 ympw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739210116; x=1739814916;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DkdEH6sUVSYdCOe90izcf7TmjmouF03Sb+YzoMm2llg=;
 b=igZysbyyPGibqRNpoiiGCLAdM1WCMCyTsjKtoGf5xa9IoiPW5fD1x5fFTMyBtM/5Nw
 Oa/dZfAfX112n87ri1vjig81hnR7ISiEEmxH2iCPjZ0x29UI6kWmXcrICJij6IQVFn2S
 3Zay9/f2znojolbd1uFKfxyqrRW93I+CWK/Eb5zim2mCgWVkOQNG2T5JAAMEBI7x0Lx9
 W7HQAUHqYXokWNsZHrb34eczo1E0hfS7su+/m9tCsqPmReGBrqPsAXhV9dhZfRX3MM11
 Tnw/QldneShFFlRzZDnq6TTqiMJAQegy/h91Di4V5f3jW5Nso1lrBqimtdCHjzy54YXo
 3KXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmVuw88Du+ZdydTY1sw21oF/YU/QvU3SL0Ftdt/NjPpX0rAK9Vc4W3Ex0MVc99jnVsUk4QagPnTV2p@nongnu.org
X-Gm-Message-State: AOJu0Yy0rx5sem9HxvB0+mTFXPz1+R8oUm6vcJKya/EymgRXuNdwVngg
 VponI2hxXEeYnq18SZC73G+t9AX2VZ3NpC/kylDSKW1KnTpY/+JAb2S8Kj6/oPs=
X-Gm-Gg: ASbGncs/6u4dOK1g52O5dygfslDsA+WF9T74oRg4baKFCaO7EpfeSoiV7ccTePSmAN6
 QzZbOVgY9tomyyXt7XcWV9ai9U3bGJdX+Pg1u48ZOHXrmA6SX+NzBZnS4KbOx6edNqvL2LO6t80
 D/Qkmb1Z37iFY2QGEvWV+vbyS8f95VE3ildtE5ib2ZFXs0MK9rjsO6yeLgxealtMF4dOoD9PBQ/
 rghi6YctIbK2EVFxSHw+LfSLCKh2SnRnufiIuB6lzT2ZNxIBI+kkxXgMSrQKu8AEOsmx+sMTipf
 ra7WeqkXRucQ59rdr0JmUEGxKXKLoJdpJaJzSygrCR1RaXerHDvPNQY=
X-Google-Smtp-Source: AGHT+IF0fPzzW08zdDIHghwC9vu9rTRnSyRwpROktUNftvlnGXsL5Dkh3qDb4iHxy6DqaeoXmSH1jQ==
X-Received: by 2002:a05:6a00:4217:b0:730:8a0a:9ef8 with SMTP id
 d2e1a72fcca58-7308a0aace1mr8766715b3a.22.1739210115682; 
 Mon, 10 Feb 2025 09:55:15 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73077975f05sm4441135b3a.14.2025.02.10.09.55.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 09:55:15 -0800 (PST)
Message-ID: <86b29db8-68fd-4380-915d-e8e70f71909d@linaro.org>
Date: Mon, 10 Feb 2025 09:55:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] util/qemu-timer.c: Don't warp timer from timerlist_rearm()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250210135804.3526943-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250210135804.3526943-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2/10/25 05:58, Peter Maydell wrote:
> Currently we call icount_start_warp_timer() from timerlist_rearm().
> This produces incorrect behaviour, because timerlist_rearm() is
> called, for instance, when a timer callback modifies its timer.  We
> cannot decide here to warp the timer forwards to the next timer
> deadline merely because all_cpu_threads_idle() is true, because the
> timer callback we were called from (or some other callback later in
> the list of callbacks being invoked) may be about to raise a CPU
> interrupt and move a CPU from idle to ready.5A
> 
> The only valid place to choose to warp the timer forward is from the
> main loop, when we know we have no outstanding IO or timer callbacks
> that might be about to wake up a CPU.
> 
> For Arm guests, this bug was mostly latent until the refactoring
> commit f6fc36deef6abc ("target/arm/helper: Implement
> CNTHCTL_EL2.CNT[VP]MASK"), which exposed it because it refactored a
> timer callback so that it happened to call timer_mod() first and
> raise the interrupt second, when it had previously raised the
> interrupt first and called timer_mod() afterwards.
> 
> This call seems to have originally derived from the
> pre-record-and-replay icount code, which (as of e.g.  commit
> db1a49726c3c in 2010) in this location did a call to
> qemu_notify_event(), necessary to get the icount code in the vCPU
> round-robin thread to stop and recalculate the icount deadline when a
> timer was reprogrammed from the IO thread.  In current QEMU,
> everything is done on the vCPU thread when we are in icount mode, so
> there's no need to try to notify another thread here.
> 
> I suspect that the other reason why this call was doing icount timer
> warping is that it pre-dates commit efab87cf79077a from 2015, which
> added a call to icount_start_warp_timer() to main_loop_wait().  Once
> the call in timerlist_rearm() has been removed, if the timer
> callbacks don't cause any CPU to be woken up then we will end up
> calling icount_start_warp_timer() from main_loop_wait() when the rr
> main loop code calls rr_wait_io_event().
> 
> Remove the incorrect call from timerlist_rearm().
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> As far as I can tell, this is the right thing, and it fixes the
> "icount warps the timer when it should not" bug I'm trying to
> address, but I'm not super familiar with the icount subsystem or its
> evolution, so it's possible I've accidentally broken some other setup
> here.  This does pass the tcg, functional and avocado tests,
> including the record-and-replay ones.  I've cc'd it to stable as a
> bugfix, but it definitely merits careful review first.
> ---

I don't completely grok icount either, but this patch at least conforms to my 
expectations.  The fact that it passes record/replay is a really good smoke test.

So fwiw,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

