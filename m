Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20483D1951A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 21:55:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkUYW-0005kK-6T; Mon, 26 Jan 2026 16:55:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1vkUYN-0005eF-Uh
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 16:55:24 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1vkUYM-0007rd-0T
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 16:55:23 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6581af9c94aso9681293a12.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 13:55:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769464519; cv=none;
 d=google.com; s=arc-20240605;
 b=fdbM9XBnEZFdU95K8fOyoDL/BFogzzRsrssMsr2n9y1wGxHwRXqCxu2MwHosFBKEeT
 r96ia/jCwDHBf06WIMrgN5fIhaRml9aF/4NBx2mM86ctU+4XHetEUVJbNwEKs1qb4ulF
 +LqSIgr6dG7B95Q1W5pk8CBl5yndGoGCDjz4FziDemRjlLAXlmqSzYaYfQEj1AnMFjc4
 6ApM2lEUl6Rawovc7chyPomTPzjFJd/u4hW2GZR/Pr5slmDVxwpYJKsSuVBmaxFhkFnw
 g/hPGbWLMiFVYBN+h3oApeUKUUmw+lu94vIKzx+nZGluVh7O1w8wlntHIyMQuflmyHOB
 k2xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bN2QWkDXfnVp0J5V2HN2f3kdqztG6bUn5ToUfLMWtAU=;
 fh=ymp3ym9ZolWldcADhdcYCzabqwYRs/WtRt4dU3+13dM=;
 b=HGhc7J4rc+41tjj4cX5EWCx3yYNHSaMbCod5cCHtkKrnVFswY5KN4XRT7OCoD/bwRo
 UgeLrsP6oRNCwjlAIs3UNfOl3VzAdXSIa9ozQtTtj6+diTJkpIt1K4Kl4BksmRuMoMaa
 wL3VMHhnfllNWc6X0aDjfRPydOb2gxfloyu0FoLgVSB0E2ngwJysoWBzBR9QH0idFilk
 /T8kbfSCyKiigct2tBmCMQeO2kAc6fwo6LKtco/CF6xjrY0pGN4W6M1W4WLHcTRxI4E9
 9+N9clnYwjaFaorDTip42Lviar6RSGd9JoOPNwryCZiUGVZApISe8VcgTnhYMb3DN8rU
 ZOdQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769464519; x=1770069319; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bN2QWkDXfnVp0J5V2HN2f3kdqztG6bUn5ToUfLMWtAU=;
 b=ihuHeMfDNm07Ur/JLzvau/Zk39JrQqPTRZzKLUpDHazGif98Qw2spJ7oqpcQOxzUPZ
 breTV0Fg4rcQFKHU4PR1BSmHneiv5Uxfhd2YtuKOYDaJsdUpsErPmcli8tfTwyEGxMqp
 g/rX0WpDV5emeKpOOaVB+CVRVB5RTWjCDEkFNbdJSQJJe9kwlkCmjYreVDnWQ+tTqEJQ
 cKLJ4pOKx9PFQyxBOtfazJilDe0WbY0gBAarafWm+ZZkbfimxbonq3aC5b8xLkZ7WKBl
 GapTes6MMnTISPS7p9aswvmM3Jh9nQZmhngcz5SHdPJ1fO2DrL4BDZYppJz43gvPTzfG
 ZaMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769464519; x=1770069319;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bN2QWkDXfnVp0J5V2HN2f3kdqztG6bUn5ToUfLMWtAU=;
 b=O/z8TJV6SkuzKSrRMEAeUUd11tua0yJ/cvOUpBt2PBr+BRo7RUs08MP8aeWmEuozsK
 ZQCYokZW5/jP+w22wnGAzMQd17tvWdYtZDL2O2DP3p8J3COhr+eH2GxrnLB66CMtkqzE
 MhErtTk9EyPYgLCDzaLOkSzXzoIVTIoJQb20WmQ2lYf3IEUE/wHGcHX+ThxRTHpo0f97
 jRmhyjFwK4wmXsf8HKW/eV24KR3MLmzjvthvr+roIsW/03iVrBi27rYftp6Au563gseG
 u+kxv30+iG/nPikNOc3VjnvWYO/iKqsQlSOrNMlkZ7NgvFp/PPgiWUUwVPYpSVND/gxK
 Am/w==
X-Gm-Message-State: AOJu0YyQ2c4QPu+F3OLiv8ZRadpWbbBx2TQF/6ffMg9PvY80ydLAHyTi
 Z04NS6b+jicHBBx3VPV2NwFJlJdQKKIwSmS8MHxGzmgMcZnhhX5n20ehXQl+0ZYsd12UhRR1ULv
 EujsXSdIZi/F7ZFOhasO4ws+dkTaGlls=
X-Gm-Gg: AZuq6aKUp8TjRWF+t/efzwTKtDJB63YCyqwpO5m5CR3rRGGLwj0COjL784HAuJu/sri
 G/NojWsiqnpDa3keq8iug0tWpYYYDQVLfQ+pw1DqS96Wd9sQ/66ZPXiHfNvIVEwzD29eWIvrVGX
 3F4g/xt9IXN/w2XPitL5KsVHlMjTQ4aq2xAUvULGIdPXk3bI4ocH83hIXTIc4kDCKkyWMrYVx00
 gpvjYDohr5gTUPIsF7fz5tgkzUjW/2PktJwGSahFiGr8WN7MpPzABOVHaKVMoee8wRwDPI9b5e2
 Fjzi
X-Received: by 2002:a05:6402:13cd:b0:64d:2822:cf71 with SMTP id
 4fb4d7f45d1cf-658706d7cadmr3493672a12.29.1769464519244; Mon, 26 Jan 2026
 13:55:19 -0800 (PST)
MIME-Version: 1.0
References: <20260126194735.46167-1-stefanha@redhat.com>
In-Reply-To: <20260126194735.46167-1-stefanha@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 26 Jan 2026 16:55:07 -0500
X-Gm-Features: AZwV_QjRsHTpKi3SSwwtIfhwnCLO03_2zVuJmJ2_Chlh6T3PKvX7-mAj2IGhOUc
Message-ID: <CAJSP0QVJDkvZeDLLumcRrDoqDYj82TZopw86tESAxVfbXE9_KA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] scsi: persistent reservation live migration
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, pkrempa@redhat.com, 
 Paolo Bonzini <pbonzini@redhat.com>, Alberto Faria <afaria@redhat.com>,
 Hannes Reinecke <hare@suse.de>, 
 Zhao Liu <zhao1.liu@intel.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>, Qing Wang <qinwang@redhat.com>, 
 Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This series requires Peter Xu's "[PATCH v2 0/5] migration: Notifier
fixes for 11.0" to ensure that the rollback operation happens before
the guest resumes on the migration source.
https://lore.kernel.org/qemu-devel/20260126213614.3815900-1-peterx@redhat.com/T/#t

Stefan

