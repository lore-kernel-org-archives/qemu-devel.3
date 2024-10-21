Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE96D17141
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 21:59:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t30Qr-0002so-MM; Mon, 21 Oct 2024 17:59:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t30Qq-0002sa-1p
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 17:59:20 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t30Qo-0007RS-DZ
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 17:59:19 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-7ea16c7759cso2647694a12.1
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 14:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729547956; x=1730152756; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DqFI8ZYDnDsXFc50KRTwaLB1LYve6odeXoK/WEo0osk=;
 b=LduYETB5hH/zXLQFyJTc5/45MyMs8br0GlVCoZH9mTqc/fCfgeOwLoedvpoGOwkuJL
 Dpc1tGb3MyceDI59QVXORPuBdz8mAyM/QjLRCvcXlzh53QZWupDjSBdXvAbfsaVcJguK
 evI+SfYhQGoWYSQMYRA4TlZDqf4fSGoqrEcabgDauVEyxyQy+eRQtBagL9grgsEORvUe
 pFbbM7yr9JW04wecPyZeZ0EoXrQWmA5y4l08gXT6tF2YT07z8X/2Rdl1bEw3Fpn8Wm5Z
 Gz5IaUYlS7ysbxnn5qglq4xguhjTx4eF23rQYlLlqIx9GdOFbnZ+igolCJuawmNuC3HV
 0Jww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729547956; x=1730152756;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DqFI8ZYDnDsXFc50KRTwaLB1LYve6odeXoK/WEo0osk=;
 b=uJHXzz1OSDSd37Kv5MHLQVR+Ap1YZMK8URA4zHP06J2T5IQfLZywvuBJtVNw96jw+E
 J1Pc2l5JxfW+eWzBUUMi+4m+RGf3rleW9w1tDTuqkqzPC/eXvopzUTZhYb346BMUEfqC
 xcs2xsTQd/snFs9b8GC8fX5AOTM+bEZ4oB/egjlRCsxATAua2uR5ZNwpXuu2CcsvxVFg
 y/lkPq1c0IBhuQ53GLRT8Wc/5tZz4bgwnKEvKqdhLqFs1W7+e+9JZVJeTRsSwMHS6/4j
 JPsZe9oZcKVzCoCfPp4BWKOS1Xm3oiFh1taXm+18BNs3FFny7PiAm6zGzP0p/dKIWf0E
 mOlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrHmzjEzbFeDGYXTb0biZODpfe1x0IIfj99nHsNv8A3MnMTzW8H893uC5IsmS+aFKjtOofKVGScskf@nongnu.org
X-Gm-Message-State: AOJu0Yz4jWWo9ZC6SbwLHdMJ4FQW2Gkw+WmM4lups8dbHj8E6KlGY2PL
 69cSnlAx5TiXjPMK2dXFW80mJ44gTGFa5p76N9APZK9EFa58Scs66Gd2izJifmY=
X-Google-Smtp-Source: AGHT+IE6t4nIEYXkBI6wDxzqueRXT6YuAwS35JkaFsCsHBlPX55LpSWi2c41A4OhCulkvsTTBqiDqA==
X-Received: by 2002:a05:6a20:b40b:b0:1d6:fb1b:d096 with SMTP id
 adf61e73a8af0-1d96dece7fcmr441366637.26.1729547956596; 
 Mon, 21 Oct 2024 14:59:16 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7eaeab581b1sm3621191a12.45.2024.10.21.14.59.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2024 14:59:16 -0700 (PDT)
Message-ID: <f7e574bb-a780-4f5b-a511-ab9f0aa86f31@linaro.org>
Date: Mon, 21 Oct 2024 14:59:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/7] tcg-plugins: add hooks for interrupts,
 exceptions and traps
Content-Language: en-US
To: Julian Ganz <nenut@skiff.uberspace.de>, Julian Ganz <neither@nut.email>,
 qemu-devel@nongnu.org
References: <20231021122502.26746-1-neither@nut.email>
 <cover.1729355735.git.neither@nut.email>
 <fad67d3f-5b8d-45f6-a1aa-666852a0dad4@linaro.org>
 <8929cd79ce653b55e7cb166300782cb13727da3b@skiff.uberspace.de>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <8929cd79ce653b55e7cb166300782cb13727da3b@skiff.uberspace.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52b.google.com
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

On 10/21/24 14:02, Julian Ganz wrote:
> Hi, Pierrick,
> 
> October 21, 2024 at 8:00 PM, "Pierrick Bouvier" wrote:
>> I agree it would be useful. Beyond the scope of this series, it would be
>> nice if we could add a control flow related API instead of asking to
>> plugins to do it themselves.
>>
>> If we would provide something like this, is there still a value to add
>> an API to detect interrupt/exceptions/traps events?
>>
>> Note: It's not a critic against what you sent, just an open question on
>> *why* it's useful to access this QEMU implementation related information
>> vs something more generic.
> 
> The motivation for this API is a plugin that simulates a RISC-V tracing
> unit (and produces a trace). For that we actually also needed to
> track the "regular" control flow, i.e. find out whether a branch was
> taken or where a jump went. That wasn't hard, especially considering
> that the TCG API already gives you (more or less) basic blocks. Still,
> we ended up tracing every instruction because that made some of the logic
> much simpler and easier to reason about.
> 
> We realized that we need a trap API because they:
> * can occur at any time/point of execusion
> * usually come with additional effects such as mode changes.
> 

Thanks for sharing your insights.
I think there is definitely value in what you offer, and I'm trying to 
think how we could extend it in the future easily, without having 
another callback when a new event appear. In my experience on plugins, 
the least callbacks we have, and the simpler they are, the better it is.

Maybe we could have a single API like:

enum qemu_plugin_cf_event_type {
	QEMU_PLUGIN_CF_INTERRUPT;
	QEMU_PLUGIN_CF_TRAP;
	QEMU_PLUGIN_CF_SEMIHOSTING;
};

/* Sum type, a.k.a. "Rust-like" enum */
typedef struct {
     enum qemu_plugin_cf_event_type ev;
     union {
         data_for_interrupt interrupt;
         data_for_trap trap;
         data_for_semihosting semihosting;
} qemu_plugin_cf_event;
/* data_for_... could contain things like from/to addresses, interrupt 
id, ... */

...

void on_cf_event(qemu_plugin_cf_event ev)
{
	switch (ev.type) {
		case QEMU_PLUGIN_CF_TRAP:
			...
		case QEMU_PLUGIN_CF_SEMIHOSTING:
			...
		default:
			g_assert_not_reached();
	}
}

/* a plugin can register to one or several event - we could provide a 
QEMU_PLUGIN_CF_ALL for plugins tracking all events. */
qemu_plugin_register_cf_cb(QEMU_PLUGIN_CF_TRAP, &on_cf_event);
qemu_plugin_register_cf_cb(QEMU_PLUGIN_CF_SEMIHOSTING, &on_cf_event);

This way, a single callback can be registered for one or several events. 
And in the future, we are free to attach more data for every event, and 
add other events (TB_FALLTHROUGH, TB_JUMP, etc).

> Helpers for discerning whether an instruction is a jump, a branch
> instruction or something else would certainly be helpful if you wanted
> cross-platform control flow tracing of some sort, but afaik given such
> helpers you would just need to check the last instruction in a
> translation block and check where the PC goes after that. Additional
> callbacks for specifically this situation strike me as a bit
> excessive.
>
> But I could be wrong about that.
>

You're right, and the current cflow plugin is more a demonstration of 
using existing API than an efficient solution to this problem.
For cflow detection specifically, I think we can do better, by adding 
instrumentation right where we chain/jump between tb, and of course, 
tracking other events like you did in this series.

> Regards,
> Julian

