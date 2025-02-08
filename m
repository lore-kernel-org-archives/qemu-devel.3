Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C754AC02198
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2025 14:04:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tglR0-0005sA-HP; Sat, 08 Feb 2025 09:03:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tglQx-0005rR-O5; Sat, 08 Feb 2025 09:03:48 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tglQw-0000Ib-4D; Sat, 08 Feb 2025 09:03:47 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5dce1d61b44so5379884a12.2; 
 Sat, 08 Feb 2025 06:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739023424; x=1739628224; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PwaDvF+dS3NCjuPu2C9bL3ayC6VObjqLv6KEnE2K94M=;
 b=QRAVmugvHC5RIhL9PYp5DNGmkLAtLzxCCmrC5uhvvGMY+jxX7xBgEDqlTzYwVVBMD2
 5qdGIAcw5nEFhi+INOx4dq471Yzog2pM/M1Dys0MrLEGi+ntq9BJYtWtqFeVfJjYlPmo
 pvn4XpryAR4kW0c0ROXX589aZfqeaL3flGZb7xmTQj9uPoc9GRwC7lS8Aclcug6qf8Zv
 PIxNdt5l9lyBInLZ4DEoms0Ty6H+XqZj72YbagqvhFwbLJcV9OgOdcMXD/FYANsZ/rFF
 Ihg5p9I024aMGp8EyZpG+xuDBVwTdcV7UCfu5TpwHbCcrfbFV0HjiWpN154/vMhvj2pz
 NgTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739023424; x=1739628224;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PwaDvF+dS3NCjuPu2C9bL3ayC6VObjqLv6KEnE2K94M=;
 b=mBXC/JgwVXt+AYH3bBg/sKKrNIKajiZYav46LlV6YlZybyA/tswE9mtP+P9jYu7Gkx
 IKXA6NqEJKeuJjBNDDPyBlUbIYrjiMQUFehQ+rui1S9/0IYoojzllncQVGo9Gx0TclAK
 JHVrVIWx+975h2r1nvWxohd8kSxyXm5pgmCD8t6sXFGinPeZaFDKil1Im4DY6tA6vNQ6
 PPIlRzlOH/diub7eZjx0eseRYMRsIUZYPyN9+NZmbv1Z/vBnk4TFPCLFd64QwbgF0poB
 uEQIHd31rtiSn17XTt4GdcDl5SsL5UoxCZZed3AKxpxrwjK48o9DbDumOKjsWbgRUSbV
 qKJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZtxmbydCBcw+2BU/uGj3+mFAQph5DSfcxQOrOc/CDVV13BOPafkCHvekHvgh2A38uXDeH9RToSPL96/w=@nongnu.org,
 AJvYcCVl83Dq4tJIff4K4yjwvFGaNx4xnutchdq2WpOn9Pp8rqFVaxXFrdZum9SAW9WiCGrfd4eRWsLsh8+b@nongnu.org,
 AJvYcCX3tswbSl/omwVQe1YtBMfLHy7+uJPd9PLMFV0Av8O0V2YmhGWsEVu9GgTyqK0poy522adB42q13ejW@nongnu.org
X-Gm-Message-State: AOJu0Ywmd5DQaJ1U8AiMlFvYDB4fk2Xz8ujHrWx4FF1y3b8unYwfO1us
 mU7M7Q4c9LWIPjZwutmL9gLLGiPNEGmME2ILN/b3pRwJ1o/+I5x2NcxWo8pjpT/wkIy125VP+yC
 mrP3xR0Zb550poCIpkUQsVnYhLDg=
X-Gm-Gg: ASbGncs9uoWlulFOPKMf8cOA1CtppE1ma15J3xuSV4eeuvanl0J+upxOsfOK9ZFjkwW
 6InPodQmX1Yus63e9ABTZbaGoAeoJuH4LWQ4lJqECG588yeSN353u18vGOQTYFHVVZ4KtelE=
X-Google-Smtp-Source: AGHT+IE9pCWjdGr5QUUjVCgfSM7+RyTcedinQMkza8wgRwbdufNpzBNw4be1P3uDLZBWyNqdqEOJB5vQgMX3v6ZjM2E=
X-Received: by 2002:a05:6402:3907:b0:5d0:b925:a8a with SMTP id
 4fb4d7f45d1cf-5de45019b56mr7841665a12.16.1739023423605; Sat, 08 Feb 2025
 06:03:43 -0800 (PST)
MIME-Version: 1.0
References: <20250206111514.2134895-1-pbonzini@redhat.com>
 <298a7473-e5e5-418d-8902-2cbd30730db6@linaro.org>
 <CABgObfYzncjR=DtvE8asLfqJA89JjatMzs352F=4PbfTBrq1sw@mail.gmail.com>
 <f64a58c5-1080-49de-915a-56d4895d51a1@linaro.org>
In-Reply-To: <f64a58c5-1080-49de-915a-56d4895d51a1@linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Sat, 8 Feb 2025 09:03:31 -0500
X-Gm-Features: AWEUYZnUCgmoEbr4lJ5AJ7KAQ15XTZDw4k5joA6yvKgFPR3eV7toCvnt8X3Vp0U
Message-ID: <CAJSP0QUqxRPG_sM4XtJiFUBh+JmBafVCFTRnH62-XhS2LsJoZw@mail.gmail.com>
Subject: Re: [PATCH] rust: add --rust-target option for bindgen
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org, 
 qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x534.google.com
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

I merged this directly into qemu.git/master.

Stefan

