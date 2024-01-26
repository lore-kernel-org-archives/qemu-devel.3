Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B8AFC47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 17:12:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTPju-0007cJ-W0; Fri, 26 Jan 2024 12:11:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTPjt-0007c6-BH
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 12:11:37 -0500
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTPjr-0004Bw-Le
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 12:11:37 -0500
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-51028acdcf0so696854e87.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 09:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706289093; x=1706893893; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=JlJvVzfog2PFE7h67PYJk0UWktlhKhamO71DpKY/6ww=;
 b=dIuyDscpmuOPl6cfoL1+TSqifuZ1Phao6nyVQY0OJyQui7DQUhS5cP4NdskDUaz9Yi
 Mrhk3sJAct7x3GFboNBibf5KmWtfKD97DB/HY4jWtycMHmbOeOPh9EpdMI15SSm6i5X7
 lutY0SWEuSSkd30iKS1x0P0IaNfClWpUO3SYw11R3tfn936jfrUIK/adaedCrfrb+W49
 oHmBiDmC1xOIofUzhvA5ywpYU9nmJDmWK/wiTbt2HueTI3B/58JyL3lnieg/U1MgsbOU
 NsQuC/iABD6cV8nauaQcpwaJqY5JHy6IbeyD8A+sI2mDQ4S5gE4JWNRjjIpZ+zKZ1woa
 Pjlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706289093; x=1706893893;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JlJvVzfog2PFE7h67PYJk0UWktlhKhamO71DpKY/6ww=;
 b=J4cGi5fKdMzPEdUdgIJt7uxwUiVMR6zgRCKykYT5mv60+xlikzTMTPDfgWBPvrTFin
 Ijol6loIXeUcH4ozHVn+MTHWjDgF0T9Ywzz7/EqV9zTAZjbbgeiOpfbz/8DvD51pLSyK
 Tg2+SdUJOoxYSFAf5AvoTdhyX57rWqKWy6XJmS88SmSahlH68RMvgXWkd1E2TbJ4Epil
 k/Cnn6A81qIwhmY7l7ycO1IqSiwPzGlSZiGl17gHhv6pXZ4QzqmPuHsu5VP6/WnI8buU
 JK4eSsjiIHlLGniZ6Rw0p9JXUJC34Axd1gRkE8kReDL5w12NpZ37iXZgBgiqvmb+RaL9
 wSvA==
X-Gm-Message-State: AOJu0YwE65LbnZ7FUkZLViG2tLbQmQQzsQUii3FRhQ5DzVf0PiruWwyE
 MV3FF9G8Y+ows/oBf00+S8HGkA4U+FxhkWwzatdi+LdtleEx8ym8Lv481fTFHomp2c+b8bvYuUE
 ZUg9Y+pHGwwm+5fjfcq/PwTtVGkY67rmJZo8ovd+Meg2zcpXl
X-Google-Smtp-Source: AGHT+IGHK5ZKJG894JxnlV8EX8FOsh2LhgeMdMZKwvnZMkqYiPpyXF8KqBkNYssB7llCprW4vWE626rfJ5UUVYjAPWU=
X-Received: by 2002:a2e:b8d1:0:b0:2cf:457e:61fa with SMTP id
 s17-20020a2eb8d1000000b002cf457e61famr116051ljp.37.1706289093128; Fri, 26 Jan
 2024 09:11:33 -0800 (PST)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jan 2024 17:11:22 +0000
Message-ID: <CAFEAcA_0cpjog8RVb-HYPU+APrLSR_J=pRcDMj+v5XywrGeUAw@mail.gmail.com>
Subject: intermittent failure in test-aio-multithread
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Anybody got any idea about this one?

ERROR:../tests/unit/test-aio-multithread.c:371:test_multi_fair_mutex:
assertion failed (counter == atomic_counter): (316636 == 316637)
(test program exited with status code -6)

See https://gitlab.com/qemu-project/qemu/-/issues/2127 for links
to the CI job log.

I think this is the first time I've seen this particular failure;
CI job was on an AArch64 host, in case that matters.

CCing Paolo as the last person to make significant changes
to this test case...

thanks
-- PMM

