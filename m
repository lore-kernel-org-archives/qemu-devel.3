Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 607F5C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 09:19:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uchEL-0006HR-2Z; Fri, 18 Jul 2025 05:18:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uch9r-0002Jm-Jn
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 05:13:35 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uch9p-0000LZ-Pe
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 05:13:35 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3a6d77b43c9so1489333f8f.3
 for <qemu-devel@nongnu.org>; Fri, 18 Jul 2025 02:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752830011; x=1753434811; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tMtPjRXELbNHZ/a5argmjfOTYLCyxkCFRhNU2rNrFZg=;
 b=XzesmwrT9YMPiBmrVaKeLtnZuIkoIz6twq2ynCbp33CXmHw3dL8F34Yu6Xln9FfWL0
 ePNAgs5TKdiG7NfHIcwd9BDYbO+A1Uf5UOpRTUc8Q1sDyXoEUakuJsc9uqkektuzl0mb
 RTDHnz9tSiC1pvy7l0dS/NRlBeEYE/zkUHJZgEC+TEzSaeJstlynnH/yLRulRBeTpjL7
 cQRuoNgpmRovKvEttYNBcsjVgEQVpv8zp9u+8IOELN2yt/O4q8W3HF3LY0SH8EzV5sve
 Jx9bDJL5Vqm1ybyt417Ajqa7iqEqCl/q4wP7TC8WBgsLn7RJl5vtmKAtpyHAJe8PqfAw
 rokg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752830011; x=1753434811;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tMtPjRXELbNHZ/a5argmjfOTYLCyxkCFRhNU2rNrFZg=;
 b=dj+PRz8Y4TXpRUEEEHEcVsKikJhCGToDGhvJ2yeSemJ9amxGCCOyo2cKvBLrkqxdjl
 ZPua4AsOmfbswCECl7wwndH58+CVQGPnJz8eXZ9P3Z7GS0R8LyJc8eIhTVFZ+NYT0bs9
 OMikCtdVrSAtjOs6b7gF+LcAXgql/REBktq3NKMvFw7+HA12KiJsogec6kWNNXoG6KWf
 sC8xRv6m/iIwY+of9MzRRwb39G0Pl5PIOHUdgdi6azlR9bvyPXVbAal4nF/4NrLyF/Vn
 oPEe/6BMO4gtpypqR0wotZUsWvoM1jUeScStDQro4puEFbzezzm6JxNvkeMT9YWs2Fou
 XXLA==
X-Gm-Message-State: AOJu0YxpZ4oU0R0limchHKsd8YR4FvZM/tI1uBu4pRI6jFHuOUrKC5TS
 KhwC2m7C6PlCMld7KsqH7ad6k3TRWLziMGQMo5l/0sWIfKltmghi/XBebkLWmvRtFfQ=
X-Gm-Gg: ASbGncsKBqsw4dU87tv2/FqPkQ0kE8wVpot7YXMzrhb48RV63M0CKS+b1bU/sVWQV6U
 IxDwX019+waq0eaqzEPheNHRSkm6HAuKkzpTx/ch6z5lUHrJ5lv85FotH+ut7FgIjRbAK9Vssr8
 9wjCJyNWIKIB1YHCKGn7T7PqoVGjdXeJprjpixCkno5ytufNowXarI/+nqPxX3DWtdz/UcIy1Z5
 bUCruI3iClnqMsHrIJBHi8PcOVB49gfgNEZfO9PbtspbFm5wer+TzAfOU2OwXfTnonq7RMgwoox
 VehDXPDna5K6yyKGQmYt0a8Wcg43TsHdeYVf700VUm+gZ+679o67jzfN4/fFdrtWh52VC7XVjWO
 mEnnjwPVOoad5YOj8X14lNHKrtaU8u7GJfZQdFrb+k3ZUjuTuL+mPU4h7Zg24gX5eoVo=
X-Google-Smtp-Source: AGHT+IEB3bYAhATC+t5yBH+3ypAkPzv/kHpVeUsEzz6eTzbNpmDcFFkmzuXT567orfWWmVx+yrRIvg==
X-Received: by 2002:a05:6000:1a85:b0:3a4:f744:e00e with SMTP id
 ffacd0b85a97d-3b60e4be7aemr7962537f8f.4.1752830011019; 
 Fri, 18 Jul 2025 02:13:31 -0700 (PDT)
Received: from [127.0.1.1] (ppp-2-86-210-241.home.otenet.gr. [2.86.210.241])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca487fdsm1267145f8f.48.2025.07.18.02.13.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jul 2025 02:13:30 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH 0/3] tests/functional: add more CLI args
Date: Fri, 18 Jul 2025 12:12:51 +0300
Message-Id: <20250718-functional_tests_args-v1-0-54d4c6207690@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABQQemgC/2WN0QqDIBiFX0W8npA2rfkqI+JX/5qwalOLQfTus
 zXYxS6/wznfWWnE4DFSTVYacPHRT2MGfiLU3mDskXmXmYpCyKLiNevm0aZcgnubMKbYQugj48I
 6I1EqV59p3j4Cdv718V6bgwM+56xPR/iza/J1q3+3QzP3+wMDKEB2ylzKSupF7B8GIjI7DYNPm
 pRKKqwUN5Y22/YGe2b8itcAAAA=
X-Change-ID: 20250718-functional_tests_args-12cdb5e56d84
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=978;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=NFeZ9nZTsB3Yt9P/vIjmwLzRNSsWQUVXyQmpX1/he0Q=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm9laEE1YmJuUC8wdGRKaDNJTUxZTTB4QndmSXRoClhPS3Q3ZzR5d21Tc0JDRys1
 QVNKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYUhvUU9RQUt
 DUkIzS2Nkd2YzNEowUC82RC85RXBsek9udjJITVFsMGdpWVRRM29iZFJFa3gwSU00VTZZNThxcw
 pXbWxLSkRka21GUkdaanU5MDhxRXpPbU9TSDNuUnM1RVQxeVMzWi8wQ1hudXdvbFpKa1lLRjBnc
 UFJOFdGaDdWCktmZWJHSlY1LzQwa1F5MWlKYnh6YVlFeDQrOVliZTdINnhCeUNPZ0Y4YldndU5W
 N00reUlEanl6U1NmV096Z1cKNkZpMW81ZnBaTHZmeEdybUJjQUg4VlpZNXNRNHZKNEJxQklYTmF
 aZjJ0aDYvR2UwMXl3eWdDMDU3SUtGbW1rKwpxYmQ0Q0NNNFMrdTVNVlFNR1RvRGk2dnFCWWtSTS
 tjUFREdmNpSUxCRDZ0U1NzRzZ2cXRlVE4rSGZnRWpkeGNECk5aM2JUSTFKMUZlUWZSd3hvbDNYS
 TNPVnU2SlQzWWlhVzZtdDlka0Q0dWNrbEdWQW9QcGl2TlptVkIvSG5RT0kKbjc0N1B2bk9XUW5p
 MmZpZDB3UE0wemZDSGtQbHk0TTB1cTN3WlhOOGJNamNFbm4xMGIyaU1lMHM2MTA1cFFGZApUQXB
 NVE9HTFN5WVRYMVRKTW0vMFN2S2FSdlZVOTJEdXRXU1V2UHUzWjJxYWRxWThkWkh5UUsvY29kL1
 BGUjhICmJOdVl0WUo3TjN1b1Y4ZXZ6TVJRY2ZCMndSeWZZU1lRcXRxc0pGUlB3c2tzTTV1Ym1Rb
 2ZybE5Oc2hER2tvZk0KcnRoTDZsTkl4Y3VJMy9FWi8zcUVIRy9ndVNvU3BvN3h5L2dJRm1ubDN2
 SG1Kd2VBcUdSK3EyMjE3NkZNa3VXRQpsY2QwMVF1dldNZWZtOTd3aENZNTl5dTY2ZGJjRlRQTU5
 NcnUycUkwa01XcE5ZMmF5RE1nMGNKSEVaVUFXYnB1CjFIUmx6Zz09Cj05N2wxCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x436.google.com
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
Manos Pitsidianakis (3):
      tests/functional: add --keep-scratch CLI arg
      tests/functional: add --list-tests CLI arg
      tests/functional: add -k TEST_NAME_PATTERN CLI arg

 tests/functional/qemu_test/testcase.py | 45 +++++++++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 6 deletions(-)
---
base-commit: 3656e761bcdd207b7759cdcd608212d2a6f9c12d
change-id: 20250718-functional_tests_args-12cdb5e56d84
prerequisite-change-id: 20250716-functional_tests_debug_arg-aa0a5f6b9375:v2
prerequisite-patch-id: 4ccc8f39ffb382d31c8e6450c43a5f8d177af044

--
γαῖα πυρί μιχθήτω


