Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 211DAC3DA5D
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 11:23:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWwY6-0004dZ-5J; Thu, 25 Jul 2024 07:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1sWwY4-0004cT-1M
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 07:22:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1sWwXz-0003B3-Us
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 07:22:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721906529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W/RcU6ENJ/Nt41p8RxOylXqN7jgSp+MCYSjVSMYB2J4=;
 b=ihx0xHnrX7E1EBjinfuSfneLAta0vqSWYWszfr5MFK8UGlB3Xtoxd90qGH6PF6Bx0YeKr9
 0PNCotksf2G9D0qtYA9vjDR6o6j6Y8MEbKHWz5Gl0TEOO5zVCZ1HNCFnkaKp+y3w2hetOD
 E3OXVymsdQ+d3VPvzWaN+uW8DSZ7+rA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-GDxkEo6YOj2elQaybVHeFQ-1; Thu, 25 Jul 2024 07:21:01 -0400
X-MC-Unique: GDxkEo6YOj2elQaybVHeFQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-36860dd1fe8so162319f8f.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 04:21:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721906460; x=1722511260;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W/RcU6ENJ/Nt41p8RxOylXqN7jgSp+MCYSjVSMYB2J4=;
 b=Cc71B3xd572+B03utB3apJOWq46uA5ukTIiSLCCx82pozVddfZLYTFvh8hI0fwn5Ic
 dRuntFWiPxhcQasGucpnrrYIdzdhGi9WSD7foZyAU/UziYWHs0NTfWJzArYfjwzIeVVG
 mOZatR0+YYSC8vKfTK1GyJjtzydIIqKpPqrE0Obf4i2bEanH+MEKpdUydAg1TZCXktQH
 T9eTiFh9RRsoF7U1/AvpINC2pGHEHFngUeECh1FuBXkBiZKLwyLMmgvq400dojTZWHO8
 AoAFA42Ttom5lD12a8BbNqk0RqrcYTIpCBrjCr42lIGqCXJoZ4Tkwsf0NqS2XezXmirN
 XARA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGPrNnEtE/m/g9rf2kr2GWHoMHJB6n/VpXLP0JTSwDnUgH8OT/3ov7/pqRgxD5AHQ8Ovi/54wRmPhK@nongnu.org
X-Gm-Message-State: AOJu0Yxwno0aBosR5EDgwNvCvuBQPII/K2vUivLThfE8Yez/ptrZyVDm
 Zp0iJEZldvbnwqWPxMbmtf8FL92ogro9air0LRbdtFBBhnFpruMnN4oAXLkkBeYuJZLJ6iqj25x
 ijaVHMPalduzfwEO4wbFBGrkNYNUAqN/3DSaFRbfcDQOzzl0/nPZ2
X-Received: by 2002:a05:600c:4511:b0:425:7ac6:96f9 with SMTP id
 5b1f17b1804b1-428053c0936mr8553315e9.0.1721906460438; 
 Thu, 25 Jul 2024 04:21:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFs0hS+4jr12gekyxSSo+/sBI5EgsvR7qp+YV72mbT4WUmt0CTs2xCHVE2M9xlSdygkPfJGjA==
X-Received: by 2002:a05:600c:4511:b0:425:7ac6:96f9 with SMTP id
 5b1f17b1804b1-428053c0936mr8553185e9.0.1721906459941; 
 Thu, 25 Jul 2024 04:20:59 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:b231:be10::f71? ([2a0d:3341:b231:be10::f71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42807246ca4sm22683535e9.11.2024.07.25.04.20.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jul 2024 04:20:59 -0700 (PDT)
Message-ID: <541d338f-bffc-4393-a501-92d01e5c8edb@redhat.com>
Date: Thu, 25 Jul 2024 13:20:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ptp: Add vDSO-style vmclock support
To: David Woodhouse <dwmw2@infradead.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Peter Hilber <peter.hilber@opensynergy.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-rtc@vger.kernel.org, "Ridoux, Julien" <ridouxj@amazon.com>,
 virtio-dev@lists.linux.dev, "Luu, Ryan" <rluu@amazon.com>,
 "Chashper, David" <chashper@amazon.com>,
 "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>
Cc: "Christopher S . Hall" <christopher.s.hall@intel.com>,
 Jason Wang <jasowang@redhat.com>, John Stultz <jstultz@google.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 Stephen Boyd <sboyd@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Marc Zyngier <maz@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 qemu-devel <qemu-devel@nongnu.org>, Simon Horman <horms@kernel.org>
References: <14d1626bc9ddae9d8ad19d3c508538d10f5a8e44.camel@infradead.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <14d1626bc9ddae9d8ad19d3c508538d10f5a8e44.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pabeni@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi,

Just a bunch of 'nits below

On 7/24/24 19:16, David Woodhouse wrote:
> diff --git a/drivers/ptp/ptp_vmclock.c b/drivers/ptp/ptp_vmclock.c
> new file mode 100644
> index 000000000000..9c508c21c062
> --- /dev/null
> +++ b/drivers/ptp/ptp_vmclock.c

[...]

> +/*
> + * Multiply a 64-bit count by a 64-bit tick 'period' in units of seconds >> 64
> + * and add the fractional second part of the reference time.
> + *
> + * The result is a 128-bit value, the top 64 bits of which are seconds, and
> + * the low 64 bits are (seconds >> 64).
> + *
> + * If __int128 isn't available, perform the calculation 32 bits at a time to
> + * avoid overflow.
> + */
> +static inline uint64_t mul_u64_u64_shr_add_u64(uint64_t *res_hi, uint64_t delta,
> +					       uint64_t period, uint8_t shift,
> +					       uint64_t frac_sec)

Please, no 'inline' in \.c files

> +{
> +	unsigned __int128 res = (unsigned __int128)delta * period;
> +
> +	res >>= shift;
> +	res += frac_sec;
> +	*res_hi = res >> 64;
> +	return (uint64_t)res;
> +}
> +
> +static inline bool tai_adjust(struct vmclock_abi *clk, uint64_t *sec)
> +{

Same here

> +	if (likely(clk->time_type == VMCLOCK_TIME_UTC))
> +		return true;
> +
> +	if (clk->time_type == VMCLOCK_TIME_TAI &&
> +	    (clk->flags & VMCLOCK_FLAG_TAI_OFFSET_VALID)) {
> +		if (sec)
> +			*sec += clk->tai_offset_sec;
> +		return true;
> +	}
> +	return false;
> +}
> +
> +static int vmclock_get_crosststamp(struct vmclock_state *st,
> +				   struct ptp_system_timestamp *sts,
> +				   struct system_counterval_t *system_counter,
> +				   struct timespec64 *tspec)
> +{
> +	ktime_t deadline = ktime_add(ktime_get(), VMCLOCK_MAX_WAIT);
> +	struct system_time_snapshot systime_snapshot;
> +	uint64_t cycle, delta, seq, frac_sec;
> +
> +#ifdef CONFIG_X86
> +	/*
> +	 * We'd expect the hypervisor to know this and to report the clock
> +	 * status as VMCLOCK_STATUS_UNRELIABLE. But be paranoid.
> +	 */
> +	if (check_tsc_unstable())
> +		return -EINVAL;
> +#endif
> +
> +	while (1) {
> +		seq = st->clk->seq_count & ~1ULL;
> +		virt_rmb();

Please document which other barrier pair witht this one

> +
> +		if (st->clk->clock_status == VMCLOCK_STATUS_UNRELIABLE)
> +			return -EINVAL;
> +
> +		/*
> +		 * When invoked for gettimex64(), fill in the pre/post system
> +		 * times. The simple case is when system time is based on the
> +		 * same counter as st->cs_id, in which case all three times
> +		 * will be derived from the *same* counter value.
> +		 *
> +		 * If the system isn't using the same counter, then the value
> +		 * from ktime_get_snapshot() will still be used as pre_ts, and
> +		 * ptp_read_system_postts() is called to populate postts after
> +		 * calling get_cycles().
> +		 *
> +		 * The conversion to timespec64 happens further down, outside
> +		 * the seq_count loop.
> +		 */
> +		if (sts) {
> +			ktime_get_snapshot(&systime_snapshot);
> +			if (systime_snapshot.cs_id == st->cs_id) {
> +				cycle = systime_snapshot.cycles;
> +			} else {
> +				cycle = get_cycles();
> +				ptp_read_system_postts(sts);
> +			}
> +		} else
> +			cycle = get_cycles();

Please use the brackets even for the else case

[...]
> +static int ptp_vmclock_get_time_fn(ktime_t *device_time,
> +				   struct system_counterval_t *system_counter,
> +				   void *ctx)
> +{
> +	struct vmclock_state *st = ctx;
> +	struct timespec64 tspec;
> +	int ret;
> +
> +#ifdef SUPPORT_KVMCLOCK
> +	if (READ_ONCE(st->sys_cs_id) == CSID_X86_KVM_CLK)
> +		ret = vmclock_get_crosststamp_kvmclock(st, NULL, system_counter,
> +						       &tspec);
> +	else
> +#endif
> +		ret = vmclock_get_crosststamp(st, NULL, system_counter, &tspec);
> +
> +	if (!ret)
> +		*device_time = timespec64_to_ktime(tspec);
> +
> +	return ret;
> +}
> +
> +

Please, don't add 2 consecutive blank lines.

Cheers,

Paolo


