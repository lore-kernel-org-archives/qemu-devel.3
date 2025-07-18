Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A807C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 11:05:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucitp-0002kg-HJ; Fri, 18 Jul 2025 07:05:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ucitL-0002Uy-LR
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 07:04:40 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ucitJ-0005mA-JF
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 07:04:39 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4561607166aso15303455e9.2
 for <qemu-devel@nongnu.org>; Fri, 18 Jul 2025 04:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752836675; x=1753441475; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Uj2qgeZFyr7Em3n41LHV57OtxrQ1RjI4Jy/5FREBoiY=;
 b=YbrHuRzhlrhBUaVI86ppfo2S7K/lln2FUZU1/Vfp7pP/PjPlbawH5XtBSRkdpXH6oi
 n+5cToUcsKEFpUnhcYPKj1OCTfrUTKA6qS76DtO1Z/988Ogq8wq1XoEau0SSxKFyavrJ
 FSZm4znkALOONG7bd5ARTZBL5qpOekceSeNf/XUQ0lNPyhphMwp5Ti5uB57eZGQOL0Qa
 TcmXnx+6n3HDTNZ8v8ltfrMA3cnDIQsBwla5kVmJFVHBkAB5CMM/gfaDwrH00xVZ5VQG
 Km96TWeTKb5c4TOHk3a3j7zpuscHXzdaGrbdX/uQc0jSsSceLj+1VUJ/W7HPiDPcXsJk
 prCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752836675; x=1753441475;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Uj2qgeZFyr7Em3n41LHV57OtxrQ1RjI4Jy/5FREBoiY=;
 b=ai050tw7AUSbdrn7bU7lDGgSjC9J++9fn2sclUjX82oA6gvK38+mGukBHLSVlbWQ4n
 mHXJSrP3ZVKd4V008qua6hQDOmOV2I72nltMFyKgWScn1YJ5/zzX5jdbM/QKfae+RjCT
 ced7WhVkV3Jv5XZxwhh/sbMu2DF9j1+W5Lrk2idTsjQgQwHWrg4gf20yyGwEHxJ4qAvi
 EM2dHLEf2+E4CSL22X78fRm+Ib5dLj/sAljc8/oyUqveEdPBs9jn4m5CO9Bxf7d7DC1b
 lNgjmRjrqlWsjFnpMM2AZSTx8MsAfg7tT+zgIkPovmXL9bZrBlZn60X/s3raZvPbp9hx
 vYaQ==
X-Gm-Message-State: AOJu0YyZuKbKKRn47m4d3y4GkczxuhID20cBLqEZAknGJCDKaDB6ppBh
 w1g9JR1k2mIJwYgBwXsX9aZ9OZDUmfGd+dBNx+aTyA0wWr45135853q4QQcvHKqPCAOOUOxL5Sp
 zPxBz
X-Gm-Gg: ASbGnctysqaPKF+XIkjuw2H/9vIlFFE/9V1iXSbll66hM4ZH+3fotaF3eQ10XgZge4Y
 oOz65TmISBtOVCNiQMzBHWK04WdGi150r6TcSrxvhDWMWzV3BkEEdjTfG9X9+CnWAqfiep0Fv+B
 3gVme0fPjHJjBOhx64J9+FUL8mJ9AxoF27whf0mE5kht9s+65ukHwvP4kGCSau+IdUTz9dIYoka
 lS0l30+dSzuUUMaIXYfq0bvOXTdHKMnXDQnctSufxZvZl3O3t7WznXBVvioh/4A9EGmL2lHgXQV
 IihWMYSkogJ5jLxYNfakhu/kBU9YAge4q/q9zs3/H3tbJsmCPqPCzZGgXrRhPBfaBHxlvkxrmPL
 62bD9vmwFlVhu0CLaHRzMH0JAPsdQhO5tRJTZDnAit+Izgiv90ShPtL4fhJ/m11/kpD0=
X-Google-Smtp-Source: AGHT+IF095c5sWY8Z3bmCB6O/BPEgdOhCFOYDoMK2j9IUX4Mbxm32pmsRjDvCU+Cvh4NjhAdarfdHA==
X-Received: by 2002:a05:600c:450f:b0:455:fab4:4b80 with SMTP id
 5b1f17b1804b1-4562e275cd0mr101009115e9.19.1752836675388; 
 Fri, 18 Jul 2025 04:04:35 -0700 (PDT)
Received: from [127.0.1.1] (ppp-2-86-210-241.home.otenet.gr. [2.86.210.241])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4562e8ab891sm76117585e9.35.2025.07.18.04.04.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jul 2025 04:04:34 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v2 0/3] tests/functional: add more CLI args
Date: Fri, 18 Jul 2025 14:04:24 +0300
Message-Id: <20250718-functional_tests_args-v2-0-cde6e08bf98e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADgqemgC/4WPyw6CMBBFf4V0bU1baHms/A9jTB8DNgGqbSEaw
 79bYOHChcs7mXtO7hsF8BYCarI38jDbYN2YAjtkSN/k2AG2JmXECOOkpBVup1HH9CT7a4QQw1X
 6LmDKtFEcuDBVgVL37qG1z417vuzZw2NK+Lgfv/Qk29nil21ATd1qwFISyVuh6rzkzcxWh5IBs
 HbDYGOT5YILKAVVGq2+mw3R+dc2a6ab8M+CmWKCeWEKLRgpRU1OvR2ld0fnO3RZluUDAyBD4ys
 BAAA=
X-Change-ID: 20250718-functional_tests_args-12cdb5e56d84
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1200;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=rg2RR5PlYm801cu1xp4mp6KG1bz+uusyNgbdLuiyEXw=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm9laXBCNTJ6WEtZQTloWFhaR2ltNVFCT3pZMzdTCjZhcVBiUjE5UDZKbUtQZUIx
 Q3VKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYUhvcVFRQUt
 DUkIzS2Nkd2YzNEowTjNTRC85d1ArZ3lJaExrOWo5OTB3M3FETGN5N0F1ODliTEI4c09hTEUvVA
 p4UVhQS1BHUlFTd0JqdW9lY2JkNUwzVjhWdmN5bkpGb2xmMDhHUE5jaGc0ZlVUVExoaXZleWpiS
 0w3UFFyWXE5CkNqcThkR0xxajBkMG9BOXFNOStYaFozSTUvMi9rMHZvamhkUGQ2L00wZWVtUXFB
 UTNONFVPRWt4V1RrcmtNeXkKN21Vc28zTGV4N2k0RmZhUEpFNi9zNnBIS28zWXVydUhjeXBtVmZ
 OajViL0hFdDQ0RUFIMURvUmN4ODV4clBGegpqVjFNTmxaL3pwL3JYZWJHZ0NVMnNJU2tIZklheE
 14Nkp2UHYvMGVJWHFwVTBpQ1lDTVdmRkgyVkRTZmRBSGdLCitXN3RNNHV6djZUQ2Zsb2NRMTNhe
 DJmMU13K09BZkFYc0JTTWxOTGhqL0ZSWVpkYmxqSDVDbG00Slk3UUcxbCsKNkwxcW13TFdtd0Jl
 eklRWktJNlp4dHpOWjdGUGZyY1pySEswbTh5WUMxT2ZXRDlHSk1sSzlaU2JPclE4ZHFhTQo2SjF
 IdFhMemZWekxLeFdLeThYaERiQWdyaWFjNWh3Y0F4YTFJVXdma2Jra3NEU3pPYzNOek5kK0FnMU
 c3dzhECkE0dDZZdjQ4NUJvdEtraTB2YldaZk1nMU9qZjRyYzJmZ3hsODNqS1lJQnJub2Z3amU5Z
 FoxL09UcUxhWmxUU2YKVlRkN1hVVFAvMUtNSktOTlNsc05Qb0hHNWoyWHFyci81aktId0hsOGZq
 V3huYmVKQmc2TnIvVEdYV3I3SERYcAp1YUJXcVJiM3lPdjc2bU44RjRnMzh6VXh6V3BsTGYrZVI
 1RHdFakpkVW5Db21xaFJQcEpqYVRCdEtVZUYrZ0JrCk40SVM0Zz09Cj1UYVYxCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x329.google.com
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

This series adds extra CLI args for functional tests, useful for
developers that run test files directly.

It depends on a previous patch that adds a --debug CLI arg, and is
encoded as a b4 change-id dependency, so it should be fetched and
applied automatically when using b4.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
Changes in v2:
- Fixed invalid -k value passing when -k was specified more than once
  (thanks Paolo)
- Link to v1: https://lore.kernel.org/qemu-devel/20250718-functional_tests_args-v1-0-54d4c6207690@linaro.org

---
Manos Pitsidianakis (3):
      tests/functional: add --keep-scratch CLI arg
      tests/functional: add --list-tests CLI arg
      tests/functional: add -k TEST_NAME_PATTERN CLI arg

 tests/functional/qemu_test/testcase.py | 51 +++++++++++++++++++++++++++++-----
 1 file changed, 44 insertions(+), 7 deletions(-)
---
base-commit: 3656e761bcdd207b7759cdcd608212d2a6f9c12d
change-id: 20250718-functional_tests_args-12cdb5e56d84
prerequisite-change-id: 20250716-functional_tests_debug_arg-aa0a5f6b9375:v2
prerequisite-patch-id: 4ccc8f39ffb382d31c8e6450c43a5f8d177af044

--
γαῖα πυρί μιχθήτω


