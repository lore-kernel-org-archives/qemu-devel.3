Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA5F1D3176C
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 17:49:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8Nfl-0008Sr-35; Tue, 05 Nov 2024 12:48:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <payton@privy.io>) id 1t8NPB-0004iu-Rp
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 12:31:49 -0500
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <payton@privy.io>) id 1t8NP9-0000y4-Ol
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 12:31:49 -0500
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-539f53973fdso13705e87.1
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 09:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=privy.io; s=google; t=1730827904; x=1731432704; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=YIqUIpuVpT0RSKhVs3pELyL47iWrVPf3o4E2AOLkMNE=;
 b=BcIelbd4S3nF/j98LEFX32cOElWeftYMfFB57ih/BWCYuRvOPnaFOxWfH8wSqCIAo8
 3Jz2OPyBeqn1/TL/x/XPLu4xTaPu+auWkgodPGjSV8uMx1gtueoTgGnoq5sN5hO9fpX5
 fgI3+chdFv5pIP4DkddERR4RNadmzmM6sp3xSR3AUm7R63yhu4cqcZOjPGFxYm3Cb8I9
 gFbNaUbk2hKXUx/7YW6WnIUw9St+IvcQBci1/aybaKFSdnx+kqNcWxHMhokFa0IS/Z8H
 pAzEibJ1KBsSVTd96YBysVU6+Y+v5BS0apXHqrj8nmVjfi8Um7BoTM43lYVtHkQ/la20
 ZRFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730827904; x=1731432704;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YIqUIpuVpT0RSKhVs3pELyL47iWrVPf3o4E2AOLkMNE=;
 b=tydeKeUufMToPj+LaJ/HmVBd3iDLvkPGemF1xZ/sh34dhbC7/nTgByHzDC2UNDh9Fz
 WlOHsQamDpHDq7XG7LKLCz0h6bAOwu79k4T4bOkBogdWWkN623ab+GewP1nYpoCF+86/
 uUIpnql67ime4JAc5/Va+7OBtl3GamWa8kHYtaShz4w6JAgGsb0gv1AZOktJFzwYYd5u
 2NP9vZaLvU5LIWGmheztRrT9GIhdtJ+8/AUqDfdyJPTP0EsAUwdpoZFqnanlPo3OVyvs
 g0RtrH0VqvtD30IqwO+GOUrw64CYiO2VP7tGz4Z+RnSY1lR/k/ZsJNudJsuLejf4WnUG
 xSKg==
X-Gm-Message-State: AOJu0YyU3vu9asBcF763sSAigKK3raPbg8jSuS84TBtAH6W5QJK/nVcQ
 EDe+hG/kJLi6JWRSMX1NGomEmGzlAX1Vvdo8timvXG2xHvdouDcTN/U0D+pVGJjpm9unBvh67M4
 ygyVx/WXFHpRv+Lg1j8ipQ5tZTe2hPi2G6hQEEUdCqNCXdQdgtSg=
X-Google-Smtp-Source: AGHT+IGvUFGjNWBQkQ0p0bmDCYtIEJr25E50sLdCBeRK217x2gx59jhyQw6hxBH6ufY0SJxtfjH3ZYE/1texyNqQL/c=
X-Received: by 2002:a19:6902:0:b0:53b:205c:e9ac with SMTP id
 2adb3069b0e04-53c7bc08ae4mr5815764e87.20.1730827904050; Tue, 05 Nov 2024
 09:31:44 -0800 (PST)
MIME-Version: 1.0
From: Payton Garland <payton@privy.io>
Date: Tue, 5 Nov 2024 12:31:32 -0500
Message-ID: <CADVAEoB-UoTtdFDfbBAeRGB0TKTw51G59-EpZ7un4vjET4329Q@mail.gmail.com>
Subject: QEMU Nitro Enclave Emulation on macOS
To: qemu-devel@nongnu.org
Cc: Dorjoy Chowdhury <dorjoychy111@gmail.com>, graf@amazon.com, 
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000063856c06262dc672"
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=payton@privy.io; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 05 Nov 2024 12:48:50 -0500
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

--00000000000063856c06262dc672
Content-Type: text/plain; charset="UTF-8"

Hello all,

I have been watching the Nitro Enclave Emulation patch
<https://patchwork.kernel.org/project/qemu-devel/cover/20241008211727.49088-1-dorjoychy111@gmail.com/>.
This would be a huge win for developer experience in Nitro Enclave
development.

I ran into some hardware issues and am curious if there are any known
workarounds. I was messaging with @Dorjoy Chowdhury <dorjoychy111@gmail.com> on
this issue and they suggested this group may have some ideas / definitive
answers.

*Goal*:
*emulate AWS Nitro Enclaves locally running on macOS with Apple silicon*

*Attempt*: *built vhost-device-vsock
<https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-vsock> and
qemu
<https://gitlab.com/dorjoy03/qemu/-/commit/fe4ddb4e5b99136c948e687b8b18a505decc57bf>
(on *@Dorjoy Chowdhury <dorjoychy111@gmail.com>* 's branch) in an alpine
Docker image and attempted to run both with this script
<https://gist.github.com/payton/4ec0a08e618888adafb4b9a888513d91>*

*Problem*: *enclave emulation requires KVM support per the latest
documentation
<https://gitlab.com/dorjoy03/qemu/-/commit/fe4ddb4e5b99136c948e687b8b18a505decc57bf>,
which is specific to Linux, so even running Docker with privileged access
does not help because there is no KVM on macOS*

*Question:** is there a known way to get Nitro Enclave emulation working on
macOS with Apple silicon? One option that comes to mind is Apple's
hypervisor framework, but it's unclear to me if that can be a viable
replacement for enclave emulation.*

Thank you all for the support.

Best,
Payton

--00000000000063856c06262dc672
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello all,<div><br></div><div>I have been watching the <a =
href=3D"https://patchwork.kernel.org/project/qemu-devel/cover/2024100821172=
7.49088-1-dorjoychy111@gmail.com/">Nitro Enclave Emulation patch</a>. This =
would be a huge win for developer experience in Nitro Enclave development.<=
/div><div><br></div><div>I ran into some hardware issues and am curious if =
there are any known workarounds. I was messaging with=C2=A0<a class=3D"gmai=
l_plusreply" id=3D"plusReplyChip-0" href=3D"mailto:dorjoychy111@gmail.com" =
tabindex=3D"-1">@Dorjoy Chowdhury</a>=C2=A0on this issue and they suggested=
 this group may have some ideas / definitive answers.</div><div><br></div><=
div><b>Goal</b>: <i>emulate AWS Nitro Enclaves locally running on macOS wit=
h Apple silicon<br></i></div><div><br></div><div><b>Attempt</b>: <i>built <=
a href=3D"https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-v=
sock">vhost-device-vsock</a> and <a href=3D"https://gitlab.com/dorjoy03/qem=
u/-/commit/fe4ddb4e5b99136c948e687b8b18a505decc57bf">qemu</a> (on=C2=A0</i>=
<a class=3D"gmail_plusreply" id=3D"plusReplyChip-1" href=3D"mailto:dorjoych=
y111@gmail.com" tabindex=3D"-1" style=3D"">@Dorjoy Chowdhury</a><i>=C2=A0&#=
39;s branch) in an alpine Docker image and attempted to run both <a href=3D=
"https://gist.github.com/payton/4ec0a08e618888adafb4b9a888513d91">with this=
 script</a></i></div><div><br></div><div><div><b>Problem</b>: <i>enclave em=
ulation requires KVM support <a href=3D"https://gitlab.com/dorjoy03/qemu/-/=
commit/fe4ddb4e5b99136c948e687b8b18a505decc57bf">per the latest documentati=
on</a>, which is specific to Linux, so even running Docker with privileged =
access does not help because there is no KVM on macOS</i></div><div><i><br>=
</i></div><div><b>Question:</b><i> is there a known way to get Nitro Enclav=
e emulation working on macOS with Apple silicon? One option that comes to m=
ind is Apple&#39;s hypervisor framework, but it&#39;s unclear to me if that=
 can be a viable replacement=C2=A0for enclave emulation.</i></div><div><br>=
</div><div>Thank you all for the support.</div><div><br></div><div>Best,</d=
iv><div>Payton</div><br></div></div>

--00000000000063856c06262dc672--

