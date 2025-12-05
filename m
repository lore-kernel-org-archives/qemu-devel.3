Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9530D33992
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 16:42:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRYsb-0005eF-0I; Fri, 05 Dec 2025 11:42:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRYsG-0005Z4-2m
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 11:41:40 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRYsD-0005m7-JB
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 11:41:39 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-42e2e77f519so1677138f8f.2
 for <qemu-devel@nongnu.org>; Fri, 05 Dec 2025 08:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764952896; x=1765557696; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+xMeV+8WI7NzeX4uz1Cvy8h0wQuT1bOBkDpoH8efHDE=;
 b=L33XwXKEAfVLhkIyrZwJyQvGkO9llD5HeX3NPsYOVCEeGm8HKNLY47SYWwRMKFfvbN
 SqWvtZgokW6ly1691KCjNyoQyaK+nDxGTNW/KUp0cVsiX/uW9IKK5jbgQ2BkJx5DJkaI
 kJr876dkqWAs38fRLncTXQnd393hi/nQI2Kynvxqi1FoBLJKXZi9Y8uKy0OzLxh1FDoZ
 eRMJ+xlK8tlO4onYFBE7KR1u6U4nxkNKWk7H5gCcxNNlRVLxApncdxMssrAeLDFwiJ1Z
 I4/cKbl2zOwBLf9OMr0cO4kpbL3htthA8iVjRnxskmlvigWZhHAEgwZIcr6RyTF5YtNA
 PeaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764952896; x=1765557696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+xMeV+8WI7NzeX4uz1Cvy8h0wQuT1bOBkDpoH8efHDE=;
 b=YXZaAYl9aZmwQVler5owhIhGHLm23RbhXRuKVqk0/H8YDIiY3590VzT9DV+PtdiDnm
 ITG1UQ+MoTpvGgnvRMqK3uLkzDnORni0eBWSJZKdvOuSSZLtIQTQmIp3nX5i5GqD4+s0
 oCEGfvj57rR5pi4tsXzfsxOm5rsy3CFzCLicQAmtqsnXQUoVDuPdtVAMGZiD2gGOgWa7
 9MONOcWlz9bTKMr3PFyP2/geeZOnNnreUrJKXEGFZEbIWz9kI2K8xCcLB+DraFiD2zRE
 tUI0wx1IxbQCfiHWd58ieeypU4DdACuvfEhLaBuvtzAnPNJOqRZwJCWDCfSeuEOTVXm7
 6rFQ==
X-Gm-Message-State: AOJu0YyisI/wWqL1+kJZ7XX8/uXvg9rhKR8g6fzPZdya+ZSlnpD4FFz9
 2aZ3oGG4KNlLNAOcaY5HOV4EDAC+J5i5Ni7xId+EqofIu0NSPUNM+UfPKyEgvDQtNMU=
X-Gm-Gg: ASbGncsn3TORoG0kgzHe6XGbRN9k93v8j6oFTb/24O6VYWfxwnhKuJ+iuAs7y+zQsqN
 3v2Z5kx1Tckxdlq7i7s1k2rNXf4Zesdn6RuUjYwn+mI/T2ZdWh+cgIKxtJSHWcEm618TnDtb/ok
 cPcuBJyyuQ1pK1w7D2f9R8FWP/RXujK93NJJuT7xHW5WaEeSVL4XTX1rq3a38TXYrP+uClgvLm4
 FtWl2EsiZT+WD6fGe5tnTCrHKnQSveVxsKlhHooAk6Cy+PLmIl55QJvo0sT0SBBSAC1rZ4xV7Rt
 NIHOA5bA/4O7Ws4p7m0ClCrnHyel+WXjZlumlQ6heLW9qw+4+pYqN+/sYVz9zffflzehdUgLO3c
 Z+pEnK84sNZ5W9Dws+9jETHfuqhP6yOSeEV5ohS4lIn3LqeC0IMUrVl9Dq0KAuusZk/vntCYsvU
 JudqONo8TOzKN91Kn18vtf5A==
X-Google-Smtp-Source: AGHT+IF3j7NguEwx/PhJA5W2r+Fn+aQzOSl8HAnX3XpZQ+GTarIKugTCUAKFYV4uOUmOXz0uW8j7LA==
X-Received: by 2002:a05:6000:2906:b0:429:c711:229a with SMTP id
 ffacd0b85a97d-42f79865bc5mr7872384f8f.56.1764952895757; 
 Fri, 05 Dec 2025 08:41:35 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7d2226d0sm9563445f8f.21.2025.12.05.08.41.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Dec 2025 08:41:34 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 36EC75F914;
 Fri, 05 Dec 2025 16:41:27 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?S=C3=B6nke=20Holz?= <sholz8530@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 13/14] contrib/plugins/uftrace_symbols.py: unbreak
 --no-prefix-symbols
Date: Fri,  5 Dec 2025 16:41:24 +0000
Message-ID: <20251205164125.2122504-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251205164125.2122504-1-alex.bennee@linaro.org>
References: <20251205164125.2122504-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
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

From: Sönke Holz <sholz8530@gmail.com>

Since 8a545a336d, `name` is unbound if --no-prefix-symbols is passed,
causing this script to break when that option is set.

Signed-off-by: Sönke Holz <sholz8530@gmail.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20251205105614.13673-1-sholz8530@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/contrib/plugins/uftrace_symbols.py b/contrib/plugins/uftrace_symbols.py
index 45fb79c7a58..21704541a6c 100755
--- a/contrib/plugins/uftrace_symbols.py
+++ b/contrib/plugins/uftrace_symbols.py
@@ -98,6 +98,8 @@ def generate_symbol_file(self, prefix_symbols):
                 size = f'{s.size:{addrx}}'
                 if prefix_symbols:
                     name = f'{binary_name}:{s.name}'
+                else:
+                    name = s.name
                 print(addr, size, 'T', name, file=sym_file)
 
     def generate_debug_file(self):
-- 
2.47.3


