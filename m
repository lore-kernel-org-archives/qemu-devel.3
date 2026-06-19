Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A60E1CD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 14:47:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waaUf-0007Iu-Uf; Fri, 19 Jun 2026 10:46:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1waaUO-0007IS-QT
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 10:46:36 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1waaUM-00081s-Th
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 10:46:36 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4921e4dd62dso16662055e9.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 07:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781880393; x=1782485193; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xT4L+uzw88PqoxSWn7LQiKQqGeTooxjlTUAl+CbxoBs=;
 b=anGCujsMmBQLlL9vDQMddeQwME/ZYh1rfAR4vUUAMXd8wNW8eh7m56OkZxTPm1DnkK
 aFIi0tJ0IaIKhoFjJxFN91Q8WBYfLDSfYfzM7TsLAITw+JrZSmH60MocBNVUEsN49HI1
 IHzjD7/RsLRUNxqfB8YHCHDderJ146Z5tbcuJyUEOBgk2ofndVILg5plFeH4qMwg4/AW
 g/z5KjTO6JGBrsyGG0woFVtKvm+Z/DbggJ72pB7UwpEzgs5tSYyrFG/O37KqWtmSU2Do
 aAFzFnVrSQZ6zOg8WBqwl3OMufax2s93PwcTS5fF0KYL97ifzQxRS1Jw+PXN2AY5FcdO
 PLPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781880393; x=1782485193;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xT4L+uzw88PqoxSWn7LQiKQqGeTooxjlTUAl+CbxoBs=;
 b=bz+nBya0IlcqSEmmfdxtfQbIn8CJvHc/GisrVdfR+oSn3oskZCTfgn0MMJcKgcRZ1j
 V05pvNbphTDjPQbQ+Agype6cZK5ZYMwv5RuoCS+9gRI4qPkfPOqwmoiKeAdqFumB6vsq
 OvFrjFN9+PajWDy3Rv6iokDK1xkj1JcEFUvGWMasyMO4E1xNG7IevkBjrZnFaZreLCVu
 9B1UQXKcVYRPrmomamdWwsoLmeri0x25bpuAviDc/Lnm2NQy6yCxrv4b6p0nlZ+Mi5Bj
 edbYuFHc0IOo7EtDik7254e2WLjCi5UdBma9w6rn60ZuLrvujkyRb8lCmd4FrxsDg9Cw
 dcVw==
X-Gm-Message-State: AOJu0YwYhlPaUK50XygkgYX+b9oN67c+Wkguwv1AmPgzSn5xjT8kIQqI
 NHcmmCk4sLXUT9Whf5dPRSvW8DPDEJVUh8yIFC0Je86spDqwvvozUJWYz0j7vsfqOWLlLAbVjcO
 Is7ue7TQ=
X-Gm-Gg: AfdE7cnHR4PYAHyJd+79BJJyPxHLOSgzHavZVVDf0RwjJ/Vuts9FVspik9eHUgqWFQT
 1AGTVuenq41FepbwL8Q9/MGYH4frOJ6PWcV0tUPJjQaZhUT2tOYc9bqdTFlt1tr+yjZj6D3S2Jx
 GslJjWVGsdLlP7KRY3prxXuq2Zx+jUL+HQ0d+xr2iUKNMkMJPOxMt55/P78IyxscoPk144jyfos
 ifvVBj+Lnyex8VYN/s/h2xd8trMyopBVIKUZYhLtjHEeLX6+WPNGX8JxCaQnyt56tslI42katHq
 +oIrlxhY8HCs5/JnjGvjAf30yhzeU4jTRFKgJDLlw3NauDWaY20UHbXjj4tGjPc0QZZ3Faasu8j
 ni0nk5pboWwveMmLZZUWeMl2Mr8u19Deh+0/x3uQe8t4HKLxTIGnSnB8n6RRHzsygOlCWMhAMoD
 w1OP+FnSkAHclP
X-Received: by 2002:a05:600c:1d19:b0:492:38c9:b265 with SMTP id
 5b1f17b1804b1-49240a448edmr50882615e9.15.1781880392497; 
 Fri, 19 Jun 2026 07:46:32 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923fd01fecsm67793805e9.8.2026.06.19.07.46.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 07:46:31 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C2A285F814;
 Fri, 19 Jun 2026 15:46:30 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH] gitlab: ensure "check-XXX' jobs capture functional test
 logs
In-Reply-To: <20260610121254.2870259-1-berrange@redhat.com> ("Daniel P.
 =?utf-8?Q?Berrang=C3=A9=22's?= message of "Wed, 10 Jun 2026 13:12:54
 +0100")
References: <20260610121254.2870259-1-berrange@redhat.com>
User-Agent: mu4e 1.14.2-pre1; emacs 30.1
Date: Fri, 19 Jun 2026 15:46:30 +0100
Message-ID: <874iiyfv09.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> A small subset of functional tests are run by default with
> 'make check', and so run in the context of 'check-XXX' CI
> jobs, rather than 'functional-XXX' CI jobs.  Thus we need
> to capture the functional test logs unconditionally for all
> test jobs.

Queued to testing/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

