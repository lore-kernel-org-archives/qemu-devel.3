Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1170ECDE000
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 18:39:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcoyh-0003DZ-Hm; Thu, 25 Jun 2026 14:39:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wcoyd-0003DK-0P
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 14:39:03 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wcoyZ-0005JF-Q6
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 14:39:02 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6976b0b2c79so107568a12.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 11:38:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782412735; cv=none;
 d=google.com; s=arc-20260327;
 b=HcvOeDeGNhRd+MtEt6pu8g1NCrrRKGMySd9GjRUM92huKO+EOEjlSsy4udgF9hA+QO
 HZDvxDAbQDrMrjVTb/+8hxkA7BDpxxc+Ko2twfZJ0eufY9A6sOrg48KjpMWuXJtW7Ob4
 D6+qMQQnxQY36dvoNz5lxTkYmPZDGzaRy5AwGy77WItRc/Lvl3CTQBTdi73BV2pTMiFz
 hH1pMdlsY44jQiKe5trZTTeAHlqHOXydof21IgyR/WpodAJwDxkSDkFiD3+OPvqE+o2t
 kBfFMNbXD3w2I6xNCZz8mDyOp7iSW9S28l4Qlb0PS2VCb2SNcaIzaDfAHAmfUXi5GtmG
 Em8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=T1lZZUaGTBA0Cr6oVHrVRgJBf08bx4TO2B9IrCJ5Na4=;
 fh=LPr50MrqyCe2aFYw4Baa+mDeoT2dXDxzq6L7uuYjA6w=;
 b=AKGr+60C2GOaulbG3xK/GL6eRP2rifz0hR3+gb6pAWA8NL2JMkq68mpegIaFawLw7I
 g4DagzUi40mX5TajtGpZTq0W0In/aS1XB7Lu0NSMZ2nL4P7E8CFILFpf6njXvA/kkUY7
 bk0IJcEUagMLKFdGzEsKerx0IPyN+wpKsOj6CG0vLCCIefqpEH2yYbS5lDOa4NrnAzQ6
 A5mkfHMsCrD0gX/jAVc7c8cD2wh+/5pQStNQ+N1vWUsoN1ThP0+Kge0IR9gWYdxH4dtc
 MI12uRKNDMdI72sSEBRA3VxnqbpnukVdHNpVZWDA8Hbtg/xaFiRV0zWZbZkTzyTe5D6v
 IdxQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782412735; x=1783017535; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=T1lZZUaGTBA0Cr6oVHrVRgJBf08bx4TO2B9IrCJ5Na4=;
 b=dzewx/kA70k3r+pi39V/SeV4zwwnfMuUznYwmp2GBnBUrripZAtOBxgYyOVdKzl67O
 hATw7wmwqes1JYpj1PPhxO1GSX3Wth2TWGv4/JEQOdSJx7bXNUxIr/Cb48xwdiQzdnvh
 3ZqPyWUtKQV0d/lwOuYHe5rWUsRsINeF0NF5mlFEJRekxA2NWcq51BIZC2ySWNc2yzbN
 0OBZ0z/4wl3G2Ca14n4rmfpK5kmv8CKsuCdq6fDfV0fU+DkKv3UTG0TaOa0kZZqd8Z0K
 s5ucetQus2MqZTu5OmVJevWpqhYRazA5KLEKN6GGsjX/ZsbyMkN/YSXgbLbjHbaPp3L6
 6wjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782412735; x=1783017535;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T1lZZUaGTBA0Cr6oVHrVRgJBf08bx4TO2B9IrCJ5Na4=;
 b=XTyCC6Zgi9pTbOheHlJqCgZ6vzbYRsMel2vGfaW5g88kC4DO3Pl+/imsICtyHlPF84
 fZ8kgTs3WiZqTXIFA1NcWkBi8yR1smvwCMsv3QE+g3IIMj15aXWipD/q+oWErgJ4t5//
 j5lRmCjvzZeU11Yi8pXSjS7Vn6A04cYgxNZsgvHIODjEBUw/b+U7TOoXhC+8E2cv03PZ
 uwEyqdGkjnFrnA/cTbltLiA3363rZjtwkYTvS4gnwPGCJYUjEwpbDLG4VMpabeMnvtVw
 kbOUNl7y8bM9E5gGpNhJCHrKegA8NSiP7W8HNGxSblvytYx8JWKGEQQoeU1vN0QTHvYq
 MThA==
X-Gm-Message-State: AOJu0Yxt9U6ZgmKaOQ4coZ42P2tzfm0bZjjnX1RHHRsEN6aXe4ma1/Ui
 EOLZQ+s5/T3Y6UPtIOP6M4judjwYDeO2UuqdW6Eg6zPJK4etQjV/K1N3Io+E/crpyFY1gIa/Dib
 lxTAx7A3xmPDfRRcof17p7mWjrT5dxPE=
X-Gm-Gg: AfdE7cnv/prgAK07u/Ng2JLIqEOe+q92OoFRFWzypqyUmlgAXa+jMxE8evSaqCODPrs
 OzzY1rTCFtrXpgT/Dw2F3uHkuM5HNvvguC3TFk9lLav6S4FHGzn45k+y81Tia0xWPvhllvW6PFl
 29G7P6pk1zggJkoQyxqwHQGj2UCXdMTsSl/MTewHjXVoeyeHt+FMPk4h5GV9NyPcnE/ef4rp3X4
 DLsYK1zkdjHuIvGEQc61X8j65W0h8QBuOenv0W7suK5fRx0i5tOV3V0orKxdjChfGouAQ8HHjAD
 BRJMWYiFnkEFKqruM97uFNcRfmndOq4=
X-Received: by 2002:a05:6402:190b:b0:697:ef1c:b5f7 with SMTP id
 4fb4d7f45d1cf-69810a32487mr347342a12.7.1782412735358; Thu, 25 Jun 2026
 11:38:55 -0700 (PDT)
MIME-Version: 1.0
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 25 Jun 2026 14:38:42 -0400
X-Gm-Features: AVVi8Cefc4b-tZBTtF-qyU5IefeRSocdPL9YpXyHVyC-qlGB1dPereGRQ9h6FU0
Message-ID: <CAJSP0QXRy1Dc_MwqtU_gS1+jOdrW=Vk6YynP75q5HP3Rz_CpTA@mail.gmail.com>
Subject: macOS builds broken in CI
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x529.google.com
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

Hi Alex,
tests/tcg/multiarch/system/Makefile.softmmu-target's
run-gdbstub-interrupt seems to be broken on GitLab CI macOS runners. 5
days ago it still passed, but now rerunning the pipeline on the same
commit ID fails:

- Good (5 days ago): https://gitlab.com/qemu-project/qemu/-/pipelines/2615134022
- Bad (today): https://gitlab.com/qemu-project/qemu/-/pipelines/2629704018

I've tried many CI runs with different pull requests applied on top of
qemu.git/master and they fail in the same way. Maybe it's an
environmental thing with the macOS runners?

It's unclear where the SIGKILL (Error 137) comes from. Could it be an
out-of-memory condition on macOS runners?

I am ignoring the macOS builds for the time being and continuing to
merge pull requests.

TEST memory-sve on aarch64
TEST softmmu gdbstub support on aarch64
qemu-system-aarch64: -gdb
unix:path=/var/folders/fc/8_hzw5tx3n7c9c04tzd6tv_40000gn/T/tmporwqcbrdqemu-gdbstub/gdbstub.socket,server=on:
info: QEMU waiting for connection on:
disconnected:unix:/var/folders/fc/8_hzw5tx3n7c9c04tzd6tv_40000gn/T/tmporwqcbrdqemu-gdbstub/gdbstub.socket,server=on
qemu-system-aarch64: QEMU: Terminated via GDBstub
TEST softmmu gdbstub support on aarch64
qemu-system-aarch64: -gdb
unix:path=/var/folders/fc/8_hzw5tx3n7c9c04tzd6tv_40000gn/T/tmpkfurbf2mqemu-gdbstub/gdbstub.socket,server=on:
info: QEMU waiting for connection on:
disconnected:unix:/var/folders/fc/8_hzw5tx3n7c9c04tzd6tv_40000gn/T/tmpkfurbf2mqemu-gdbstub/gdbstub.socket,server=on
gmake[1]: *** [/Users/gitlab/builds/qemu-project/qemu/tests/tcg/multiarch/system/Makefile.softmmu-target:35:
run-gdbstub-interrupt] Error 137
gmake: *** [/Users/gitlab/builds/qemu-project/qemu/tests/Makefile.include:75:
run-tcg-tests-aarch64-softmmu] Error 2
WARNING: step_script could not run to completion because the timeout
was exceeded. For more control over job and script timeouts see:
https://docs.gitlab.com/ci/runners/configure_runners/#set-script-and-after_script-timeouts

https://gitlab.com/qemu-project/qemu/-/jobs/15038503463

Thanks,
Stefan

