Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C943C3ABAC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 22:50:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAzC3-00084f-QO; Fri, 02 May 2025 18:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uAzBw-000849-Kq
 for qemu-devel@nongnu.org; Fri, 02 May 2025 18:49:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uAzBu-0007Em-6a
 for qemu-devel@nongnu.org; Fri, 02 May 2025 18:49:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746226148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=avJ5Ck0Ck+8ZrjsXozXEWkhWTMEE1Tb5bVb08TH/1YA=;
 b=ERWGs4L8WApwXvqNXOPyeuKVauP5CvXerbQ8SP7T7n6ab5BsJcrbwwpfqlb7N2Q/iDjDmF
 Z2Vev3Dme6m/hIJXowgNqLw45dAOmczKxmcm3xj/LQCPpII0PJco/fyqozUXstAP7uDI4p
 di7PRjpEyTQyIfp8ORwldNye2LRsfVk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-omws2AwcMWSZ8olxEvBhNA-1; Fri, 02 May 2025 18:49:07 -0400
X-MC-Unique: omws2AwcMWSZ8olxEvBhNA-1
X-Mimecast-MFC-AGG-ID: omws2AwcMWSZ8olxEvBhNA_1746226146
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3912539665cso1436504f8f.1
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 15:49:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746226146; x=1746830946;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=avJ5Ck0Ck+8ZrjsXozXEWkhWTMEE1Tb5bVb08TH/1YA=;
 b=qtZK1dgdt8WSKptJhlqvP2DHhWoCIj8u3lJtbPv4fmF1meuUu5zbzA4kPJ91lO2bp0
 0bZhhKwWTjFQoab6yHSovv0AFFqy+k/2hT+PsuDGwrvOk8yv1RlNzPoSrRyMu4gw3RP3
 5NbX6Qan1Ul8xGF/ZaXs1B9/jYfe0yAi6szCLTDUrCfhvxbowwwxpq5XD9vKtBEqq9bY
 KArvyCTYVP7qqon75btZyacfUfuL2PwHYX1APv1pUNg5a7HMr5tvqt+lL8GtSTShqTlg
 3KhMlmczazd/n6JezTYU3YyQWYf5ZLwFQsQTvWxLRcNKiEeuO/oNYW0koEKcH4xSTn0z
 lRng==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmk09zG9K3FSPZsqsnZkC+MlcVRchwytPaJvQkXzNYJjhHe5vlJ13pKTdrg1B3cTpVTGJIuYuAbYM0@nongnu.org
X-Gm-Message-State: AOJu0YyBYbCrXadE/Mo82Oa+ggrGRME8TAu21ZfTk+U7nozWfkSQ+gPw
 ucFWn8XZv/uBnciU5bXvt40/PnqDMrLw9DaPjIgSpbPaVFtCESX7hMneH9pILe2p6mb2yZqSRvz
 GeV28Mb0wDsX/ccB+wWZNiSWwCfS3lt/Z2+KhKcrIdSDVUVWV2i/Z6baehUhd2R0sHu1cdR7uVb
 s3ubMnSHjzmUpf8VKqSzyMH412WyI=
X-Gm-Gg: ASbGnctofsre3YzUmhvKigw+SNYOiRtIKHj5Ow8oAOuQl02tX0ZmeI2t+bYSzn7HRAV
 fCgMkslR0g8S+MMqjK/n0Ebfo70d5/ZvrqfKb4v8dbcmeRrzpiRoeZH2LWwULRAjD0Er3
X-Received: by 2002:a05:6000:2ab:b0:3a0:6c56:9fb5 with SMTP id
 ffacd0b85a97d-3a0984640d8mr4176817f8f.19.1746226145753; 
 Fri, 02 May 2025 15:49:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6mUbuzOIrdZ4+JrDKOO5WMH5P9K8M2HFvMkxlFLqEHt4KQPit/plEcz1YiXopgca+wjIndGT1lnXK6vhsJe4=
X-Received: by 2002:a05:6000:2ab:b0:3a0:6c56:9fb5 with SMTP id
 ffacd0b85a97d-3a0984640d8mr4176806f8f.19.1746226145465; Fri, 02 May 2025
 15:49:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250429093319.5010-1-magnuskulke@linux.microsoft.com>
 <CABgObfaxzxdBf3f-JwKA8osOwZZQf-dqpsambpAFhPvkvjDo8w@mail.gmail.com>
 <aBDBExDzR57PcRre@example.com>
 <aBT7GuLHnnS8cQCB@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
In-Reply-To: <aBT7GuLHnnS8cQCB@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 3 May 2025 00:48:52 +0200
X-Gm-Features: ATxdqUF9bveqz3YJBc517Sa_zupwFw9ArNY7p6bqyL4JSb2a8FtirmbcltTBUA8
Message-ID: <CABgObfbU43nyRfEZzFTos6ko9pfJgAE38iYyOe3DWip5v8VzNw@mail.gmail.com>
Subject: Re: [PATCH v3] target/i386/emulate: remove rflags leftovers
To: Wei Liu <wei.liu@kernel.org>
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>,
 qemu-devel <qemu-devel@nongnu.org>, 
 Roman Bolshakov <rbolshakov@ddn.com>, Cameron Esfahani <dirty@apple.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, May 2, 2025 at 7:04=E2=80=AFPM Wei Liu <wei.liu@kernel.org> wrote:
> I still have my loaner Macbook for a few more days. If I have not
> returned it when Paolo posts his patches I can build test HVF.

I have posted them now
(https://lore.kernel.org/qemu-devel/20250502214841.242584-1-pbonzini@redhat=
.com/).
They apply on top of tags/for-upstream from
https://gitlab.com/bonzini/qemu.git, which includes the other pending
bugfixes and has already passed CI.

Paolo


