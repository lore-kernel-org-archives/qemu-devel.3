Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A16E2C71157
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 01:12:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT9F7-0005m9-S9; Sat, 21 Jun 2025 21:11:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT9F5-0005lh-Pq
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 21:11:32 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT9F2-0005ZD-8w
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 21:11:30 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-31393526d0dso2016742a91.0
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 18:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750554686; x=1751159486; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9Z4oGi47jQR76eKi3Wfui8ZBTdFYE/J8BTVE/oOhggk=;
 b=MVjXkrrt/oT4QmYJUlHS5u1zY0xJtB2kHNzNciTaaPkkGYXT9p8+G+lQLH8690bV12
 5Vs+h+yHHlRzokkxeU9b/kx7Ma++n44EnWzn+MPT1zd/xFi9+PzfMCNBLjOj73jRm6Ic
 6SiiwZZ1JuUS1PnvfwLpgYd88dQEDdLqEa+z/fjXRcWjPMA2GAuroSx1W56mpGx3yDcM
 qfb5Sl9a3IFELokATe9XFry9Q3CxwKM2MuMcwNuqWTvJSrbhnYi0kTMZDplxcpCCmLIA
 uw18J1CGAvDUOAxsb4zO0TbEd/a48KI+pdRpX0ahw1jUOCivTaxHaM4z2HSGVr3j1tWk
 kdoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750554686; x=1751159486;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9Z4oGi47jQR76eKi3Wfui8ZBTdFYE/J8BTVE/oOhggk=;
 b=t5O7jAdr/p6kbqRuugy0ax9KqK1Pe2QMWRJhckZcWldD6BiLYOuOVHBySeNQSBTqTs
 sA7FX6/8SaDLaEItostmhDSD2pWo+wQUZSKrgn+JM8VbasAas9rGpUKh5Qy0mbSemgQh
 5q7YHHjzwDFuZQKwZswp0o55WMBVdUWj9aoPDJLNIGy4g9vvC+hW0vPioL+16NvpnJOH
 ht+hsVvh3u9E32z99W89wBzAONg0jGBT8NxZ5pA8e9Jv9SKhR0ZdB6vn7fn06PY4jaI9
 IqXJtwJAeVxQMCG6DkU9l2ABg8+G6ePmFxOywYlUf6qT36o5p5QF6hyURzY9obcIrFnp
 csqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtygXJ2T5gjGxvMCDbrAZne3sDHE0yJ/Kv0xT/RTdGIafAIDUiRnMwxORcG3OTWWndmGaQWFf3Hgm2@nongnu.org
X-Gm-Message-State: AOJu0YyXmfDJzL9CQMUVDCysOO/V+Lconb5Bq3awEtNBiGdSwpJZjufz
 0s5oyFf/nBOmiTugCysuptG4tZieYJP9/1VItFC1rzfRAYpr8hcjjKrazb7pCsncCfw=
X-Gm-Gg: ASbGncvrynNtvro6+510Igj2vyyobnC8rIgpSeNWZR6WpKWIVXsYRZkrqijOTwEYXJD
 ToXP+60fazQZ7HHN+BYUGqroUKKJLuMKeJfFwFKv5bGrJIyYVZitLTPKxXzW7JMBV+LQ1FFDDMj
 xCo9Jdk+pe/KJshHulbImjgMHdZyGSn3IIm6KsXeRSCD2Cn4HeXp/9lAzIbwcl1SuHl9Us6lez8
 JefttHL7VdwEDcKHIcYpoWirTXaOq02hGOPjUG++c5Qy1E43RobU9OvRj4CU6MA+SOd+DtW95mf
 F+bB6YZkuIPWa5hZqhVJllZqMfOqDl7r2lxsLfpsmvW98OzBt9m4hoKgkTtp9Bks3iaTi14oDxK
 Snwe6NOEKyilx73x7317K37yrkVLr
X-Google-Smtp-Source: AGHT+IGK+Wv78Z/Jt4bMCcGyw5tw4JdHn/dcRwwk+Xtzmiqqs49fccR7Lux1bw5KmGObEHmAV8RhxA==
X-Received: by 2002:a17:90b:57e7:b0:311:ad7f:3281 with SMTP id
 98e67ed59e1d1-3159d64e39dmr15043921a91.12.1750554685785; 
 Sat, 21 Jun 2025 18:11:25 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b3213b7093csm97536a12.73.2025.06.21.18.11.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 18:11:25 -0700 (PDT)
Message-ID: <83b1d3c0-9838-44de-83aa-5dda19014020@linaro.org>
Date: Sat, 21 Jun 2025 18:11:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 01/48] system/runstate: Document
 qemu_add_vm_change_state_handler()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Julian Armistead <julian.armistead@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20250620171342.92678-1-philmd@linaro.org>
 <20250620171342.92678-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620171342.92678-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

On 6/20/25 10:12, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/system/runstate.h | 10 ++++++++++
>   1 file changed, 10 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

