Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB691CCFA1A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 13:49:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJBEE-0007DC-Mu; Wed, 12 Nov 2025 08:49:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vJB6x-00042F-K3
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 08:42:12 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vJB6u-0001KD-K8
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 08:42:11 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-47118259fd8so6145385e9.3
 for <qemu-devel@nongnu.org>; Wed, 12 Nov 2025 05:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762954927; x=1763559727; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kqvv4c6i4mp0sBOCXGvJZ0HxeshggKA5QiiUueMIbSo=;
 b=bvDi6JF9/0ZR0fqCFITXPLRIfdUqyq120dqI54um7yBPt6kt521Af08WSKF8vxLGeb
 PKGY/vaw8Ds5m2G05GZKJkUsx5tOfk0ZF3+CW2Kk/st63nfeAxBWhgvW67ejg4gvuQzy
 uoX6gyuGWir+enlIkzcHR1T0qoroH57tXsftVFOQZgUUiHFAxEs48J243aoncUAz6p52
 vw8I/nqMYa3Qiw7j0LKATlLp38H7UwBMrJKnVkdrhtH/tiT49ejovPrqRdrpusB6ypI5
 RKQKW14f5zlwPOS0sVEh0P3F6arCHx7IAjdWun6mfkjQ0lx4CwvWgoq4GOUQVAxTcn2V
 wFzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762954927; x=1763559727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Kqvv4c6i4mp0sBOCXGvJZ0HxeshggKA5QiiUueMIbSo=;
 b=J+20xdp+Bw4Z71uB2Gc2YQOAW96oX4EqmuKp6PgtEDmqzOhwhXqZSIFusfITIxCUxK
 eAnThWYqKiRXybQZ3bB9D6oah/sAv4IOQybBuSeza0GukB0cFPA+cU8vm5YbcepKg/bG
 Ez+2DBRu3Y1LMofgjhQO6geWdE83t6hkzUuGt367Yss7l93oqkcc6TKl16jeTrWMBLWM
 d5P+wuSiRStOjah1kBDbBn9LaQ6DKDYWKuvEJ5BK7+ftK6WXoUviBLZ3ZAXSazi+4Vnj
 /lWDtOyS0HZE9YVPp/62BI3O6YiP4CqWWfOWFSIsULlek8o/2Wj4yAQ2UkCxOB9sgLkx
 TSHw==
X-Gm-Message-State: AOJu0Ywldqu1EfOzdILuKuwc6i5VXqKuWxGqJknKVQPUx63E5cpta4+W
 mNc5RYgfMfJeIZ+p4Cr1KlMUf79+R3FwHdno/4g197ngzjwBOipFPzr2pu4Eqe5xn5zACEA0C0P
 gwhGVOC4Bbw==
X-Gm-Gg: ASbGncuv5q9zCO3eFBPa9Zo0sCftl+0Ci8mPgspTwraMllO0T7FaRuqb6nCPqPXFeBT
 IWUtv9N0nxtLXB2JaAwt0AChTr2aDwxT2AbdoQ+DZ5S5WprEqHBc7V9tLGIKFL6jKttv79nOhTw
 QcPHD+QB75GzzQSP/JgR6IO4sL9YcAIwcU5nM2NMb/AfnHENGUYiO0ELtAo+Z0uQeao2RaLVC5p
 JthfOpYmqRTHVspscvWIeXdu0N+eUZNCZRtHmFaAPWcoOca3VVocxgH0JzrgoYgHz1w0aVXZO+g
 AVuLyfVOLK0eXtxzCn/6+KGQPGkC7CqmQ+6xcG1PQYzgRITxUD70QpdbIaB78Jz5WCau8mnmd2l
 JWfHEMxrqYVkOtKQI8gtQ0LaGYf8RnyQ1Jp3Kq1vx6L9q0ZZq6evcOpcmPjJvb9/qF2T/KNdJqo
 oJdmiRf4QNAhjOYHO+pqiaMtX8dr6s6pY67WePjXJmeMJCw6tKFwetRp4=
X-Google-Smtp-Source: AGHT+IHwvQAIqQo3qXpDX63W7d62iIL/ecSGXZ28juJnwIFUt5yJVNib7cQ+0pvxVRC8zDcqwe4IlQ==
X-Received: by 2002:a05:600c:1396:b0:46e:4246:c90d with SMTP id
 5b1f17b1804b1-4778707c897mr23436145e9.11.1762954926657; 
 Wed, 12 Nov 2025 05:42:06 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47787e8e743sm34172765e9.15.2025.11.12.05.42.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Nov 2025 05:42:06 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 03/10] chardev/char: Improve ChardevClass::chr_write()
 docstring
Date: Wed, 12 Nov 2025 14:41:36 +0100
Message-ID: <20251112134143.27194-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251112134143.27194-1-philmd@linaro.org>
References: <20251112134143.27194-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/chardev/char.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/chardev/char.h b/include/chardev/char.h
index b65e9981c14..df55c7f4e67 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -263,7 +263,17 @@ struct ChardevClass {
     void (*open)(Chardev *chr, ChardevBackend *backend,
                  bool *be_opened, Error **errp);
 
-    /* write buf to the backend */
+    /**
+     * chr_write: Write data to a character backend
+     * @s: the character backend to write to
+     * @buf: the data to write
+     * @len: the number of bytes to write
+     *
+     * Called with chr_write_lock held.
+     *
+     * Returns: the number of bytes consumed or -1 on error.
+     * On error, %errno is also set as appropriate.
+     */
     int (*chr_write)(Chardev *s, const uint8_t *buf, int len);
 
     /*
-- 
2.51.0


