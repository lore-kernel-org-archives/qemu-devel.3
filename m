Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FE1BE77188
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2024 20:44:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSMcq-0003n0-1Z; Mon, 30 Dec 2024 15:44:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSMcl-0003mV-Q1
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 15:44:28 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSMcj-0001Xl-Lg
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 15:44:27 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-386329da1d9so4385497f8f.1
 for <qemu-devel@nongnu.org>; Mon, 30 Dec 2024 12:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735591463; x=1736196263; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HpvD2LX7eM5Ls+eoIhMzjS99EVzQA8hi1nyUQP+H8Z8=;
 b=yefbNH42IiP2Vy2N2yI/CbQdfgsGaHa90B0hvHEgc6fgIarVkEGSKzD6VBcmxoFaQF
 +k8lhlQ7fY7PQF+XM5o8EnCMYi8T0v4S0+9l7uuUnsBo6lm1uNICyXBJEkygOxueXJMq
 7TE6kLCa3EomeaC9WV6+vZhGDJouY1783awDKvqJPqlVxOjz4iaYas4J6i0LUDvmm0a3
 P1S6wo16Ghruxtmo+hYQb8v8HWGJyVzaaMXSx6b8BE2+LdsHDemxbW4mmTgAsUhc/QMy
 kfmwQN0C3/yBdwYeWPNHmM7E6/VKsJn+3MTfeOznUwEhODI+oGy6Z8gIngFQt2+sfGRM
 c5wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735591463; x=1736196263;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HpvD2LX7eM5Ls+eoIhMzjS99EVzQA8hi1nyUQP+H8Z8=;
 b=bmp7vHSaRB5pnJX+n1SFbAYvGzscJbL58JTUmI1jGnky4JFVHbdDoNMLeTGkNEAEuz
 PupH1e4khR4xTkhZmnk68oCYYONy2gxzKH3G+Sg0Ov3OiFRvz7xyhy0jujEu7oSG2EFS
 Gw7a4gT5zgDyGh4GttMcmp6LfzOSj1ENLswWOBbfEiQqgzX4YxtDMArKgzpJip22jDd6
 GtkKgegJ0KyLHfD/iuXjgiGIV2hygsVZomEICncorsAt3JB4EGjDTOIRs3asU13xlh64
 dUQgFe6upsK7MxkljqQDVioNWglo17ABQ9iMFCrgvVCVTT59CsAht7KPsHNzk9kwd2ub
 fTQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4vxQatamL5PJtF0oN8j79ezzyuBJcFERzEHvp0PIfSM3v5qC8KtkLq72oVs29XVCZ2oBSrRMik3G9@nongnu.org
X-Gm-Message-State: AOJu0YzaE4TJGkgrXDJlMRtTzytKvmFDuljU3YH9iBLPhTpAdMps1OYe
 06kQuFrq4Ti83tGEWrnNt9KX2dEi0KTtmWqoYg17s68Lrcz8aIo8iGoV4N8J+t8=
X-Gm-Gg: ASbGncvD0dnUSfGhMmKPllfViObaS2gRHhumNeWe0oFXkVHLd+PCUvnG88voXNXvlxt
 5AzRcDfUHxXZ5ClqjodmJAnu+Ird5vHIqj5qP+Rb8zSWrgD4bbxGd33z4h+98rFwJcnDunwUMp1
 r9NveJ0PSmcnasFm2nKqH6A92T+W8siHqlK30E90O2a80vR8TdwW0uxVPqmrjMGJFM1x/XuAu2g
 gEZJkDQUoBxoXnKTgtEyY550mplC8cCsn7xCskieGKM664xFGHzpOv2myPfPl0YkKarirjU9YaI
 BIUIFVtCnKkSag+K8VYnTlP0
X-Google-Smtp-Source: AGHT+IE92m25Spb5hMRwmXPDU1MY6Hfkgyg08vk9TAemHo+6MHlR9iXO2X3BHQNO1qEnWL1Bc9kB+g==
X-Received: by 2002:a5d:5f4a:0:b0:385:f19f:5a8f with SMTP id
 ffacd0b85a97d-38a221f2d90mr28213574f8f.4.1735591463056; 
 Mon, 30 Dec 2024 12:44:23 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a28f17315sm25643044f8f.108.2024.12.30.12.44.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Dec 2024 12:44:22 -0800 (PST)
Message-ID: <39804b98-4bef-4d1e-9567-8afdafb31df3@linaro.org>
Date: Mon, 30 Dec 2024 21:44:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] hppa CPU reset and speedup
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20241230152519.86291-1-philmd@linaro.org>
 <32a4d72c-6cc2-4c33-876d-ddf66b71fab4@gmx.de>
 <c778e5f6-8b9b-4a7b-a3cd-a7f8cced87bb@linaro.org>
 <1e1b7a2b-a7bb-4feb-8443-3ff263508c28@linaro.org>
Content-Language: en-US
In-Reply-To: <1e1b7a2b-a7bb-4feb-8443-3ff263508c28@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 30/12/24 21:41, Philippe Mathieu-Daudé wrote:
> On 30/12/24 21:39, Philippe Mathieu-Daudé wrote:
>> On 30/12/24 21:24, Helge Deller wrote:
>>> Hi Philippe,
>>>
>>> On 12/30/24 16:25, Philippe Mathieu-Daudé wrote:
>>>> Respin of:
>>>> https://lore.kernel.org/qemu-devel/20241229234154.32250-1- 
>>>> deller@kernel.org/
>>>> "Add CPU reset function and speed up runtime and translation."
>>>>
>>>> - Remove hppa_cpu_init()
>>>
>>> Thanks for picking up my patches and integrating them properly
>>> with the reset code.
>>> But sadly your changes somehow break hppa 64-bit CPU support.
>>> I think it's to when the reset code is called.
>>
>> Likely hppa_is_pa20() called *before* CPU reset...?
> 
> Indeed:
> 
> (lldb) bt
> * thread #1, queue = 'com.apple.main-thread', stop reason = breakpoint 1.10
>    * frame #0: 0x000000010024df30 qemu-system-hppa`hppa_ptlbe [inlined] 
> hppa_is_pa20(env=0x000000011f822230) at cpu.h:304:17
>      frame #1: 0x000000010024df30 qemu-system-hppa`hppa_ptlbe [inlined] 
> HPPA_BTLB_ENTRIES(env=0x000000011f822230) at cpu.h:309:12
>      frame #2: 0x000000010024df30 qemu-system- 
> hppa`hppa_ptlbe(env=0x000000011f822230) at mem_helper.c:642:29
>      frame #3: 0x0000000100250564 qemu-system- 
> hppa`hppa_cpu_realizefn(dev=0x000000011f81fa00, errp=<unavailable>) at 
> cpu.c:188:9
>      frame #4: 0x00000001002f812c qemu-system- 
> hppa`device_set_realized(obj=<unavailable>, value=<unavailable>, 
> errp=0x000000016fdfebc0) at qdev.c:495:13

Assigning is_pa20 in instance_init() fixes it:

-- >8 --
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 6e5434a8e99..b0bc9d35e4c 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -193,6 +193,13 @@ static void hppa_cpu_realizefn(DeviceState *dev, 
Error **errp)
      tcg_cflags_set(cs, CF_PCREL);
  }

+static void hppa_cpu_initfn(Object *obj)
+{
+    CPUHPPAState *env = cpu_env(CPU(obj));
+
+    env->is_pa20 = !!object_dynamic_cast(obj, TYPE_HPPA64_CPU);
+}
+
  static void hppa_cpu_reset_hold(Object *obj, ResetType type)
  {
      HPPACPUClass *scc = HPPA_CPU_GET_CLASS(obj);
@@ -209,8 +216,6 @@ static void hppa_cpu_reset_hold(Object *obj, 
ResetType type)

      memset(env, 0, offsetof(CPUHPPAState, end_reset_fields));

-    env->is_pa20 = !!object_dynamic_cast(obj, TYPE_HPPA64_CPU);
-
      cpu_hppa_loaded_fr0(env);
      cpu_hppa_put_psw(env, PSW_M);
  }
@@ -284,6 +289,7 @@ static const TypeInfo hppa_cpu_type_infos[] = {
          .parent = TYPE_CPU,
          .instance_size = sizeof(HPPACPU),
          .instance_align = __alignof(HPPACPU),
+        .instance_init = hppa_cpu_initfn,
          .abstract = false,
          .class_size = sizeof(HPPACPUClass),
          .class_init = hppa_cpu_class_init,
---


