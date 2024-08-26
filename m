Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C49C5321E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 06:45:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siTTC-0007Z3-Ac; Mon, 26 Aug 2024 02:44:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1siTTB-0007YZ-Kv
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 02:44:53 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1siTT6-0000zP-JO
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 02:44:53 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5c09fd20eddso922123a12.3
 for <qemu-devel@nongnu.org>; Sun, 25 Aug 2024 23:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724654687; x=1725259487; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=5B4RWP+TuwixXz+Vvs/x2SDQhCLc/e6y8IkxjoC2Sb4=;
 b=bUgNI/6YrzIT/AakVEdlY5OM6TQkJPKLELmNtDOZcbr4QuqehuqLvrd8frGKu8vogm
 s9drUbB5w6PnETavcBk8l9h8a0syCWGi72Pu83vPWZ/P+F0ETVImWzU7y8vXXMFxYMkn
 9J06+VbdGNK//vtgk5A5IZnws8dBmLdtxbfh5xQuWWLYIvzwLme+5ee3JgAfWQl4hTr6
 yvrH2fZIFx4Eqk3qNT5K1LpzAVYKmATcdteWkeReKDXXig/XQmI7SIIakuHvUAgitTNX
 gEFXfU8zeiiHdr1zzcasZcf5KMMcLJ1IhJ1lqLl00JL0Li11vL0MWqZrWhGsXswqIkn/
 hCow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724654687; x=1725259487;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5B4RWP+TuwixXz+Vvs/x2SDQhCLc/e6y8IkxjoC2Sb4=;
 b=jozBpmfA2EYHXKYa2AEm0YIWMJEQW/TOVwvO/VG2mtVkuscW3tqZ/E0qsxx4ge9gvQ
 DmFAFC82eWGAuCZEYmUmEL3PLRCF3RD4X9zOFGM0cOtkNllu0nBhniVpmLQUse8P7Mpy
 3oC705jfIIPbWV6XSjYL28zJQCBu4cJWM7iGYq0phRk9mL61+QZ3KjybiTqbJzztxLkq
 ZHAqo17cbrop6jeUaZgihGMePx0RXw/HMXzAwjfGZmH2asUFBr1gPEFR57nD1Afb4vO7
 AcaRL0Gba7zxiGX6zduU5N7h08pvRMeTWK+HKm9ZLHNOzDYDwkNgc/HsOR/uNRxDTlYx
 StwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPl5eYd59ktQhcHo0cdhlfcoM6/d3Tusye+07qO2PexgHdBuHImvfudneFqO5wTM20xbOpV0N8ihHR@nongnu.org
X-Gm-Message-State: AOJu0YzLK/rlDqIbtuyfs0EcnqYLwTyOFMAOR7aGS157Tk9y3hqcp8xl
 uq/cAwX6cNVSJZa3dWDZRCDwLa0EA2RoopNujqJb1UWw4qGc1Hr27hkbBhRmZ8I=
X-Google-Smtp-Source: AGHT+IHshCbsuGHn1kwCEiW67PvgqTeGl/53fW0j3uFIQREAlaSUjxX+RDO00LhanaccAlz/ZRW5hw==
X-Received: by 2002:a05:6402:3596:b0:5c0:8ea9:85a0 with SMTP id
 4fb4d7f45d1cf-5c08ea9863fmr6425713a12.5.1724654686138; 
 Sun, 25 Aug 2024 23:44:46 -0700 (PDT)
Received: from meli-email.org (adsl-98.109.242.227.tellas.gr. [109.242.227.98])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c04a3cc25bsm5184093a12.38.2024.08.25.23.44.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Aug 2024 23:44:45 -0700 (PDT)
Date: Mon, 26 Aug 2024 09:41:58 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Junjie Mao <junjie.mao@intel.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Marc-Andr=?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>,
 "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v8 6/8] rust: add crate to expose bindings and interfaces
User-Agent: meli 0.8.7
References: <20240823-rust-pl011-v8-0-b9f5746bdaf3@linaro.org>
 <20240823-rust-pl011-v8-6-b9f5746bdaf3@linaro.org>
 <841befb6-5ce1-44e5-890c-4e60fcbd4fa6@intel.com>
In-Reply-To: <841befb6-5ce1-44e5-890c-4e60fcbd4fa6@intel.com>
Message-ID: <itc2k.22cnsecjnvt9@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, 26 Aug 2024 08:31, Junjie Mao <junjie.mao@intel.com> wrote:
>> +unsafe impl GlobalAlloc for QemuAllocator {
>> +    unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
>> +        if layout.align() == 0 {
>> +            g_malloc0(layout.size().try_into().unwrap()).cast::<u8>()
>> +        } else {
>> +            g_aligned_alloc0(
>
>One more thing: g_aligned_alloc0() was introduced in glib 2.72 [1] but the 
>current glib version check in meson is >= 2.66.0.
>
>Glib 2.72 still supports Win 7+, so no increase to _WIN32_WINNT is needed for 
>this version bumping.
>
>[1] https://docs.gtk.org/glib/func.aligned_alloc0.html
>[2] https://gitlab.gnome.org/GNOME/glib/-/blob/2.72.0/meson.build?ref_type=tags#L509

Hm. Was there no way to have aligned allocations before 2.72? We can 
emit a cfg from meson if glib is <2.72 and handle it differently.

Manos

