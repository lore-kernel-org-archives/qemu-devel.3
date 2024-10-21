Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23F84D0E6D5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 09:26:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2ofC-0000eR-QZ; Mon, 21 Oct 2024 05:25:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t2ofB-0000e7-HO
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 05:25:21 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t2of9-00026p-Qb
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 05:25:21 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5c903f5bd0eso7714100a12.3
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 02:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729502718; x=1730107518; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BMyzPiugsasCOpptOZqFnzcxcSGh7UZ3aQX0Zs6ye5w=;
 b=SO/3thCfh2tErEUQxSzNGbXqLrqW51P/uO1XQpzWcaCa+Pt31eIkWmBWkvmoiBdf0L
 dcQ79cnhdJJyE/sNeC+8XSqtMqggXkfqLGUMi9t56LSmbtDww26CS//WVUJah/Qu4inB
 BrQblZxFwVSH3D5V6r7w2jRmU1Ew59QlAB6PitfDCFvAIsKBYAKMg/C+y24mme+W4ygF
 lwXwRwg7yCCr2unY/CZ1UtSVL5BJnM7NhwhmvLQx4jK8W4PTZ+Azyk1MgRfU7cDTrcvO
 bkDhyt8aUVMUDYp5CrfqjWJp+JNnQMTDPEqr7JgWPNHu5vh2CtdC6F3K++VpuY3Cw3Wf
 JkIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729502718; x=1730107518;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BMyzPiugsasCOpptOZqFnzcxcSGh7UZ3aQX0Zs6ye5w=;
 b=CfrpkZnghYP+PV6LyMP/x8IZYcMJnv9hcoIvLUiIwmqlhEYPMkVkaK5l8gGTqQwDZz
 6bdr+T+SPIye8mDh7H0fzoXLEf9EEETdLUlA+iydX5eLwcKZffP00yBsZwzrT/nCr3st
 0DcvDN+Dc0XCNMaSgvS5bYDartvFgZenU7DhW+7ezbHVeDiblyCyGDL7vHXkjb4TQsio
 pHi0QTCuRLz8Jf5oJ3QUPfN6awBB09eMpolMsq0Q6FXsA0+ygurJnH5MrenyfIVpUZW4
 +LQyrJF3b9uOIB9BPfVJ5HEUXt08cqttgpaAEi5DTclmEdSssCOwL488wLbZRZn96Uiw
 qxYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8DkCXdMUs2mIZ8PIe7qs5ua/wEUFU+hVvYFZA07GPq+1M3gtkobY70M8XDfsz4HEKnliIkvv9ARrN@nongnu.org
X-Gm-Message-State: AOJu0Ywk2Is8CYwNffdhk2N93/mUEDZxSXq791u4b4N1VwWWqAaA68zZ
 T1SoxvuiL2tVu+jNpDUbSIz7VbqPnWnfWkfq2gncgrrJEoncffDBcA7pWjzzaDfIG3ayTQ8yMS9
 y45L8pusR/zruNjfQu5cc9qqytJQI4mIUDP0Lwagd2fswhU9e
X-Google-Smtp-Source: AGHT+IHDTAE9YEa+9R04KrrkA+80UPVk6AFr6VUatGo8NpUOzrq1MDsbg2yyyw8u01gjj0VfVZjZbR2MteYGZ8noHoE=
X-Received: by 2002:a05:6402:2681:b0:5ca:1598:195b with SMTP id
 4fb4d7f45d1cf-5ca15981b74mr7104640a12.28.1729502717837; Mon, 21 Oct 2024
 02:25:17 -0700 (PDT)
MIME-Version: 1.0
References: <ZxPZ5oUDRcVroh7o@intel.com>
In-Reply-To: <ZxPZ5oUDRcVroh7o@intel.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Oct 2024 10:25:07 +0100
Message-ID: <CAFEAcA8m4OeDHopFxCL3MP-cmu-PO5=2+MjNBG7YCudpKdoqDA@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BQuestion=5D_What_is_the_definition_of_=E2=80=9Cprivate?=
 =?UTF-8?Q?=E2=80=9D_fields_in_QOM=3F?=
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Sat, 19 Oct 2024 at 16:54, Zhao Liu <zhao1.liu@intel.com> wrote:
>
> Hi maintainers and list,
>
> In the QOM structure, the class and object structs have two members:
> parent_class and parent_obj, which are often marked as "< private >" in
> the comment.
>
> I couldn=E2=80=99t find information on why to define =E2=80=98private=E2=
=80=99 and =E2=80=98public=E2=80=99,
> even in the earliest QOM commits and the patch emails I could find.

This is a rather old thing which I think was originally
borrowed from glib's commenting convention.

I'm fairly sure that we decided a while back that they were entirely
unnecessary, so you don't need to add them in new code. (I can't
actually find anything with a quick list search about that though
so maybe I'm misremembering.)

Either way, there's still a lot of them floating around in the codebase
that were added before we made that decision.

thanks
-- PMM

