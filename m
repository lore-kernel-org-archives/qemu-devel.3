Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 252EFCAC597
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 12:05:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy7we-000807-4t; Mon, 15 Sep 2025 08:04:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uy7wY-0007zX-Bp
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 08:04:27 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uy7wP-0005Mm-8n
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 08:04:26 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3dae49b1293so2320303f8f.1
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 05:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757937847; x=1758542647; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cD6ONtt5eDH3z4CJYK+H+pjkUufJu6UdMVut3nJmLos=;
 b=dHJeb9lfz0D2J1eF78Kb0X5lv9u7LNS4Hnx7O5vG/BNICkAfjmUuqtD9/IjounhqCF
 PkGtNyV0buBOHZSt5x3XiEFM+zD+y+zb/h+WnBnrJx7OwbwqERkyuGqBRC0R832DeMrs
 ySGX1o/H6i1VINviiTFATbbKntRT8MQvftJ++4PjM45pPjj/HithUN9dW9HVQEPfrqhv
 y+cIL3PNyncclmzMRtSBWHHfxSnWtklJvovjBtyugY+Ew3dGqv0Vg8iveunUCUFte7ux
 VW7WiESxWgjtOv5Xiiu7wI904Jk9Q36ezccuRT8YrkEGknrNNGu9v9fnpTOxNplMdjQd
 OEQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757937847; x=1758542647;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cD6ONtt5eDH3z4CJYK+H+pjkUufJu6UdMVut3nJmLos=;
 b=TTgPNyGks5YXxxJkKgiDFxtbZupv5/rmSQ37Zpbp9SGh51K9LyF5ESuO6sDK1KK0lO
 wEz+L/2ui+rmUdrTd8PgObOWWe5vzFlN0DzShR1lwiP4x0JU0o12WXHJ3t/7kPCW0nIT
 Q+rLfIgOLbL6LL/4SEiPycstnaVEOLH5mmJFuXXlj7F+PBwzuLEyBC6vpOM/2ZdKrQQd
 oCoErNJ4ne4OftNxgXlCSIX8EyHdGRfgDv+wEmIe6U3oprvht4UzIRnoUrLG8EWNdId2
 IKBMDxN/IwSqKnHEemy1j9VU/+gX3XSDAIGykK4gbEU0PG+zYvg+oF3JviXd+rdB4m9e
 pRMA==
X-Gm-Message-State: AOJu0Yy7R0vVt/WNoRH2Z4CzQfGZMAiBJsfgM2YkExqadgreis8eq1cs
 95scnbcyx/5ypGN5aHnpZjrlEdg45erzClsTE2YdFf0GTvZw/fxU//P4ZRzpMsFI+lE/mxPGtVG
 +vcQH9tY=
X-Gm-Gg: ASbGncsmMFRyEAobTRhctXHi5WA3df0fZxx0+mk5x5Z9/2K6FhSfKB1zjjee81niLw5
 j8zIyT32m6skOzTLCaWMe5ND3MrawY3mzDEpDM9kgH6XTIkrw9f2OMB1KQgmy68BDyVYzUuCpbd
 zwTooXBoiBuDGVfxZTrVe78ge9Eme8mF01wNYqelmpLHiicPGo47vL/fvjCldJhmH2ZyJ2q13WU
 FNomZ86DwwX+qFc/X/RD3WRV4Lqc/aDBG8DZB/5e1lIcetythuLq/YFVvtOp0kTPrpJLPv9JhYG
 SikBEV1ZxhbxXF6KVhp63g78grM4oodRp1nbtFzjn8dWfjxumlhaxv2h/8GK5aelhm+aJGPz9xP
 xXIL/rMsZ0GBdMjNFb4nut+o=
X-Google-Smtp-Source: AGHT+IFuW5fRuO7FCCl4kDZKQjc5OEQob4bXf8xVYWbx0kp3n3maHwAklN1SlyxLaQdT4ljT4ZlpWw==
X-Received: by 2002:a05:6000:4026:b0:3da:37de:a38e with SMTP id
 ffacd0b85a97d-3e765a3d9f7mr13173405f8f.54.1757937846978; 
 Mon, 15 Sep 2025 05:04:06 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e81dbf9acdsm10649113f8f.55.2025.09.15.05.04.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 05:04:06 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1F82B5F867;
 Mon, 15 Sep 2025 13:04:05 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 4/6] tests/functional: drop datadrainer class in reverse
 debugging
In-Reply-To: <aMfso1ksrXgznBvi@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Mon, 15 Sep 2025 11:38:27 +0100")
References: <20250912182200.643909-1-berrange@redhat.com>
 <20250912182200.643909-5-berrange@redhat.com>
 <878qigrpcu.fsf@draig.linaro.org> <aMfso1ksrXgznBvi@redhat.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Mon, 15 Sep 2025 13:04:05 +0100
Message-ID: <874it3rkga.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Mon, Sep 15, 2025 at 11:18:09AM +0100, Alex Benn=C3=A9e wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > The reverse debugging test uses the avocado datadrainer class to
>> > create a background thread that reads from the console socket and
>> > dumps it via python logger.
>> >
>> > Most tests log console output as a side effect of doing calls
>> > to match strings, but this test never tries to match anything.
>> >
>> > This isn't critical, so just drop the functionality.
>>=20
>> We do end up with zero length logs for all console output although I don=
't know
>> if we got that far before:
>
> AFAICT, the logs were also zero-length with the current code.
> When I ran it with the datadrainer code, there didn't seem
> to be any output to be drained.  I'm unclear if that's expected
> or a sign I did something wrong, or something has broken since
> the test was first written ?

Hmm looking at test it looks like it only runs the first few
instructions so unlikely to have any output.

This makes me more inclined just to port to the check-tcg tests where we
have control of the binary and we can more easily verify things are
working as they should.

>
>
>> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> > ---
>> >  tests/functional/reverse_debugging.py | 6 ------
>> >  1 file changed, 6 deletions(-)
>> >
>> > diff --git a/tests/functional/reverse_debugging.py b/tests/functional/=
reverse_debugging.py
>> > index 1b880cda8f..9c89f5c897 100644
>> > --- a/tests/functional/reverse_debugging.py
>> > +++ b/tests/functional/reverse_debugging.py
>> > @@ -35,8 +35,6 @@ class ReverseDebugging(LinuxKernelTest):
>> >      endian_is_le =3D True
>> >=20=20
>> >      def run_vm(self, record, shift, args, replay_path, image_path, po=
rt):
>> > -        from avocado.utils import datadrainer
>> > -
>> >          logger =3D logging.getLogger('replay')
>> >          vm =3D self.get_vm(name=3D'record' if record else 'replay')
>> >          vm.set_console()
>> > @@ -54,10 +52,6 @@ def run_vm(self, record, shift, args, replay_path, =
image_path, port):
>> >          if args:
>> >              vm.add_args(*args)
>> >          vm.launch()
>> > -        console_drainer =3D datadrainer.LineLogger(vm.console_socket.=
fileno(),
>> > -                                    logger=3Dself.log.getChild('conso=
le'),
>> > -                                    stop_check=3D(lambda : not vm.is_=
running()))
>> > -        console_drainer.start()
>> >          return vm
>> >=20=20
>> >      @staticmethod
>>=20
>> --=20
>> Alex Benn=C3=A9e
>> Virtualisation Tech Lead @ Linaro
>>=20
>
> With regards,
> Daniel

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

