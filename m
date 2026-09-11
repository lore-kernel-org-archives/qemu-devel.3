Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ACBDC88E4D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 17:35:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5597-0006J7-Vq; Fri, 11 Sep 2026 13:34:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x5593-0006Hg-J8
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 13:34:39 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x558x-0008FU-IT
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 13:34:37 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-49a97714f5dso10805125e9.0
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 10:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789148070; x=1789752870; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=TYiR2aqyFv7ls9DP9XbspnugBwI3/hl4Fl6LFJoWPYU=;
 b=nRyPszFaIKXYTSe70mzXPI2mZY6Lm3gmoM+23mVOtcbtnJJR9dBarBeV/AQI/KXITg
 T7JAanAqtV2XhHzJFZQlLnCJrARjrb0s/gn1z6XQZGQYdezVSJQiKaBTHh6C4kbACB5Y
 LWqVo0b9/a4rDcKvoE8cXX4KUcC5vXCa1phbiO4gl71wNZu1CylCurIb/0gkupSeGZ5q
 I97pOpwNCEbe0ks8RXnogogj2RzpO5N9xn7n/pYVYlwk8pA3Hh8zDIr2gm17S+IODm6N
 BhzJBnE75PIUchfb+F5A1HwPUZunArzIqBN7fQuX25HeZXH7+uckVTv0r7uuboyX89Em
 QYKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789148070; x=1789752870;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TYiR2aqyFv7ls9DP9XbspnugBwI3/hl4Fl6LFJoWPYU=;
 b=glhRVkmJfdUnr90OO4FnunpyepyFvJ6qhgid1/6CakQ29OpT9yfgX8Fh8AnlgDhnBG
 wWY+E+YrZ1Rp+bLjgPwX057VUJg8nzsQz5TRk3jLIxQPLrEVe3/TzTBC+vKWVLOdZHKm
 Zk5sjirTEb6P8+jM9pIcwGEfehO3RzAehS+oi0Agrc0f7KKr95baePoe0cLszEkxRVuP
 3S0JC8MWat2phwxQmIgCuPdeRFbFZRkQRP1mzg+s5SZwjfjgJ5aNHDy1feEjzytjTd/n
 Hn5QmvmvskQs9+ELQ1nSZ5TuNCjl5vw/NtVBFq6SXvyvCFrBuAAydaVdBcUKKUwsq7hN
 /MNw==
X-Gm-Message-State: AFuF++lne5LVQCRMIdvy93QHKqxwM1UV2Nssd7hjJHWJbj5E2hYAxmIM
 ZNNUibCVUd0MhlXzoy7euAKnAsvYXD5YXIv53EzbWsqRe14XI5mrXosQrWK/lfH9KFM=
X-Gm-Gg: AYBFou20A50aWBmHx68CnehSqTgDTSH/hiBw9i59g0ga0p4tYdTwU+w92R3aUDqPCJx
 tc75GkNMcCkx31pfCT9xZySi4eWxKsqX+Dc0uHEDA0o8r/zj0ojV8idGNIGU4D9LesvfSDO72fj
 6yhyxUhMrtwGAVAZLSZo6qMDFIvH9pMLmRUePtLlMPPhiZRKsdhD0Jri6zU3/JRCMYYhQtIQsTL
 VACBfRbfBPTQjyNtSnyQ/7AEVm1jZj6AzxU57DXGV+YrP+S3h81rUGUTwBX/7Vry62Q8pZniV4W
 GylVw1rSPdv4ixHt3MlkhZRkXNllZkFA5T5trpvcqo86VY2dJ6mkpaOPV9/VGmu6mq9mmLlehdy
 U1gbdewJRY+S8psCIqP8Hc+qoTrxzw2LE5PpiDuMDwhJyny325Wi3aR1f+BuEQuHeJEb9dxWswJ
 tDuRCoIu51lDYuOejRKFhCKqNow0G0RBXdGl7SaXls+nQaL32hcJYS3EFzJuLYTwi1C8PmUFA=
X-Received: by 2002:a05:600d:8496:20b0:499:8aff:59b6 with SMTP id
 5b1f17b1804b1-49e6199234amr44622575e9.14.1789148069005; 
 Fri, 11 Sep 2026 10:34:29 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e62f58e74sm10361415e9.1.2026.09.11.10.34.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 10:34:28 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DB1325F856;
 Fri, 11 Sep 2026 18:34:26 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 pbonzini@redhat.com, thuth@redhat.com
Subject: [qemu-web RFC PATCH] blog post: some notes on the bugpocolypse
Date: Fri, 11 Sep 2026 18:34:20 +0100
Message-ID: <20260911173420.1581755-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

As we've been going throw the growing pains of AI bug bots I thought
it might be worth addressing in a blog post. I'm mainly just trying to
outline the challenges and maybe dissuade people from spam bombing the
bug tracker with lots of low value bugs in the more dusty corners of
the code base.

Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
---
 _posts/2026-09-16-bugs.md           |  203 ++
 screenshots/2026-09-culm-issues.svg | 3210 +++++++++++++++++++++++++++
 screenshots/qemu-maint-chart-26.svg |    1 +
 3 files changed, 3414 insertions(+)
 create mode 100644 _posts/2026-09-16-bugs.md
 create mode 100644 screenshots/2026-09-culm-issues.svg
 create mode 100644 screenshots/qemu-maint-chart-26.svg

diff --git a/_posts/2026-09-16-bugs.md b/_posts/2026-09-16-bugs.md
new file mode 100644
index 0000000..c3a466b
--- /dev/null
+++ b/_posts/2026-09-16-bugs.md
@@ -0,0 +1,203 @@
+---
+layout: post
+title: "Bugpocalypse, or reporting bugs in an AI age"
+date: 2026-09-11 14:00:00 +0000
+categories: [bugs, ai, policy]
+---
+
+It is a truth universally acknowledged by programmers that software
+has bugs. In a program as large and complex as QEMU, you can expect it
+to have a fair few, especially thanks to our legacy of being written
+in C.
+
+As a project, we have generally relied on our users to [report
+bugs](https://www.qemu.org/contribute/report-a-bug/) when they find
+them. Until recently, we had a slightly different process for
+"security" bugs, where we attempted to keep the details somewhat more
+secure until a fix could be made. Nowadays, we track all of the bugs
+in one place while taking advantage of GitLab's confidential flag to
+limit viewing the bugs to project members.
+
+While user bugs are found in the field, the project also tries to be
+proactive in catching bugs before that.=20
+
+Over the years, we have converted a lot of code to take advantage of
+modern language features to harden against common C faults. We have
+also greatly expanded our testing matrix to cover more of the
+codebase, both on developers' machines and in the CI system. The build
+system has native support for sanitiser builds as well as our own
+enhanced assertions for things like TCG. We even have experimental
+support for [Rust](https://rust-lang.org/), which opens a pathway for
+guest-facing device emulation to be implemented in a language that
+avoids most of [C's most popular bear traps](https://xkcd.com/1354/).
+
+However, there are some caveats, and we have to acknowledge...
+
+Not All Code is Created Equal
+-----------------------------
+
+QEMU's git history goes back to 2003 and has grown a lot over the
+years as it has gained additional capabilities. Originally intended to
+help run Windows applications on other architectures via
+[Wine](https://www.winehq.org/), it has grown system emulation
+facilities for numerous architectures as well as support for a number
+of different hypervisors.
+
+In that time, it has also gained support for numerous architectures,
+boards, and features=E2=80=94totalling between 5 million to 11.5 million l=
ines
+of code (depending on how you count). To keep track of that large
+codebase, we rely on our hardworking maintainers. This is all
+documented in the top-level
+[MAINTAINERS](https://gitlab.com/qemu-project/qemu/-/raw/master/MAINTAINER=
S?ref_type=3Dheads)
+file.
+
+![Maintainer Coverage](/screenshots/qemu-maint-chart-26.svg)
+
+Compared to a lot of Free, Libre, and Open Source (FLOSS) projects,
+QEMU is quite lucky in that quite a high proportion of maintainers
+have jobs that allow them to actively look after the code. Around
+two-thirds of the code has maintainers who are able to review and
+queue patches for the upstream tree as well as triage bugs and
+undertake the architectural clean-up all projects need to go through
+as codebases mature.
+
+In general, those paid to look after QEMU worry about the
+[virtualisation use
+case](https://www.qemu.org/docs/master/system/security.html), as this
+is where the risk of untrusted guests trying to exploit the hypervisor
+and VMM is the greatest. The whole TCG accelerator is excluded from
+this security boundary specifically because it was never written with
+security requirements in mind.
+
+Generally, we expect people running images on the
+[numerous](https://www.qemu.org/docs/master/system/arm/digic.html)
+[boutique](https://www.qemu.org/docs/master/system/or1k/or1k-sim.html)
+[platforms](https://www.qemu.org/docs/master/system/ppc/amigang.html)
+QEMU can emulate to have a fairly good idea of the provenance of the
+code they are running. Those using QEMU for security research are
+expected to take extra steps to contain potential exploits of QEMU
+itself.
+
+The designation of the virtualisation "use case" is also somewhat
+complicated by some legacy operating systems that don't support
+[VirtIO](https://www.qemu.org/docs/master/system/devices/virtio/index.html)
+out of the box. One very common class of devices often used for input
+on these machines is USB keyboards and touchscreens. At the time of
+writing, the USB subsystem is officially orphaned, which means no one
+is actively collecting patches or tending to the bugs in the tracker.
+
+While QEMU models a number of popular networking chips, they too have
+been a source of C bugs in the past. You should only be using them if
+for some reason you can't use virtio-net, because aside from security
+concerns, they will have lower performance than the VirtIO
+equivalent.
+
+The state of the bug tracker
+----------------------------
+
+If you look at the project's bug stats over the last year, you can see
+an inflection point around about March. This seems to coincide with
+the point where LLMs reached a new level of capability in their
+ability to diagnose security issues in code.
+
+![Issue Tracker over Last Year](/screenshots/2026-09-culm-issues.svg)
+
+Dramatic as this graph is, it doesn't even count a recent incident
+when one otherwise inactive user raised 120 seemingly valid issues in
+the space of a few minutes. I'm sure they would have posted more, but
+we think reporting the account for abuse to GitLab stopped the flood.
+We debated how much effort we should spend analysing those reports in
+case there were some real bugs in there. In the end, the conclusion
+was that we shouldn't waste valuable developer time on something the
+reporter didn't seem to really care about. We are almost certain that
+an LLM was involved in generating a lot of seemingly plausible bug
+reports.
+
+Verbosity has a cost
+--------------------
+
+As a project, we've tweaked our [issue
+templates](https://gitlab.com/qemu-project/qemu/-/tree/master/.gitlab/issu=
e_templates?ref_type=3Dheads)
+a number of times to encourage users to include all relevant
+information when reporting bugs. We did this so developers can attempt
+to replicate bugs.
+
+It turns out LLM agents are pretty good at filling in the relevant
+details, often going much further than the template by including a
+long-form root-cause analysis of why we are seeing the failure. The
+quality of this text can vary a lot, but we usually get at least a
+test case and a command line to run it, which is more than we often
+get from our human contributors.
+
+However, that long text does come at a cost, and it will eventually
+need to have a human sit down and read it to understand what's going
+on. And humans, unlike machines, get tired after spending many hours
+going through the flood of incoming reports. It's with some sense of
+irony that we've been experimenting with using LLMs to do the initial
+triage of bugs so we can better distribute the load by routing bugs to
+the appropriate developer. However, all this generated text has to
+eventually be read and understood by a developer who is going to try
+and fix the issue.
+
+We still want help
+------------------
+
+Ultimately, the QEMU project is still a community of humans
+collaborating on a key component of the FLOSS virtualisation stack.
+People participate for many reasons, but no developer has signed up to
+spend their days wading through reams of generated slop.
+
+The ability to submit drive-by patches to fix that annoying behaviour
+in something you use has long been an advantage of FLOSS, and we want
+to take advantage of that. Some of those passing by end up hanging
+around the project and taking on bigger jobs and more responsibilities,
+and that is the way we try and sustain QEMU's developer community.
+
+With that in mind, I thought I would mention some things to keep in
+mind if you want to raise a bug in our bug tracker.
+
+*Focus on areas you use*
+
+Anyone can aim an LLM at some of the dustier corners of the QEMU code
+base and find issues. That's fine if you're looking for candidates for
+your first patch submission to the project. However, if you're just
+looking to raise bugs for the sake of it, please reconsider what your
+motivation is. If you truly want to help the project, maybe consider
+looking at some of the existing bugs and helping out there. We have
+plenty.
+
+*Review the output of AI tools*
+
+We don't ban the use of LLMs in the bug tracker because they obviously
+have their uses in identifying problems with the code. However, they
+are not infallible, so please be upfront about their use so people
+reading the report are fully informed of the origin of the report.
+Also, please review the text and see if you can edit down some of the
+more verbose passages that don't add useful information or are
+engaging in speculation as to the underlying failure reason. If your
+agent has written an elaborate harness to exercise the bug, then tell
+it to rewrite the test using QEMU's existing [testing
+framework](https://www.qemu.org/docs/master/devel/testing/index.html).
+
+*Propose a patch*
+
+If you've automated the process of finding bugs, you might as well go
+a step further and propose a patch to fix the issue. Often, reading a
+patch will give a clearer idea of the issue than wading through all
+the descriptive text. And if the patch turns into a massive
+rearchitecting of the codebase, then maybe consider that the LLM's
+model of how things might work could be flawed.
+
+We have been here before
+------------------------
+
+Modern LLMs are certainly proving to be disruptive, but this is not
+the first time a new technology has caused ripple effects throughout
+the FLOSS world. The introduction of static analysers, improved
+compiler diagnostics, sanitisers, and fuzzers have all been
+accompanied by code churn as the issues they find have been addressed.
+I expect the same will eventually be true of this wave, and at the end
+of this disruptive phase, we will have better, cleaner, and more
+reliable software. And to achieve that, we will still need motivated
+engineers who understand the history and architecture of the codebase
+to shepherd it to the next release.
diff --git a/screenshots/2026-09-culm-issues.svg b/screenshots/2026-09-culm=
-issues.svg
new file mode 100644
index 0000000..1deae03
--- /dev/null
+++ b/screenshots/2026-09-culm-issues.svg
@@ -0,0 +1,3210 @@
+<?xml version=3D"1.0" encoding=3D"utf-8" standalone=3D"no"?>
+<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN"
+  "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
+<svg xmlns:xlink=3D"http://www.w3.org/1999/xlink" width=3D"712.535938pt" h=
eight=3D"424.080716pt" viewBox=3D"0 0 712.535938 424.080716" xmlns=3D"http:=
//www.w3.org/2000/svg" version=3D"1.1">
+ <metadata>
+  <rdf:RDF xmlns:dc=3D"http://purl.org/dc/elements/1.1/" xmlns:cc=3D"http:=
//creativecommons.org/ns#" xmlns:rdf=3D"http://www.w3.org/1999/02/22-rdf-sy=
ntax-ns#">
+   <cc:Work>
+    <dc:type rdf:resource=3D"http://purl.org/dc/dcmitype/StillImage"/>
+    <dc:date>2026-09-11T17:19:10.703624</dc:date>
+    <dc:format>image/svg+xml</dc:format>
+    <dc:creator>
+     <cc:Agent>
+      <dc:title>Matplotlib v3.10.1+dfsg1, https://matplotlib.org/</dc:titl=
e>
+     </cc:Agent>
+    </dc:creator>
+   </cc:Work>
+  </rdf:RDF>
+ </metadata>
+ <defs>
+  <style type=3D"text/css">*{stroke-linejoin: round; stroke-linecap: butt}=
</style>
+ </defs>
+ <g id=3D"figure_1">
+  <g id=3D"patch_1">
+   <path d=3D"M 0 424.080716=20
+L 712.535938 424.080716=20
+L 712.535938 0=20
+L 0 0=20
+z
+" style=3D"fill: #ffffff"/>
+  </g>
+  <g id=3D"axes_1">
+   <g id=3D"patch_2">
+    <path d=3D"M 54.295938 374.128276=20
+L 705.335938 374.128276=20
+L 705.335938 29.837812=20
+L 54.295938 29.837812=20
+z
+" style=3D"fill: #ffffff"/>
+   </g>
+   <g id=3D"FillBetweenPolyCollection_1">
+    <path d=3D"M 83.888665 367.219615=20
+L 83.888665 374.128276=20
+L 85.510184 374.128276=20
+L 87.131703 374.128276=20
+L 88.753223 374.128276=20
+L 90.374742 374.128276=20
+L 91.996261 374.128276=20
+L 93.617781 374.128276=20
+L 95.2393 374.128276=20
+L 96.860819 374.128276=20
+L 98.482338 374.128276=20
+L 100.103858 374.128276=20
+L 101.725377 374.128276=20
+L 103.346896 374.128276=20
+L 104.968416 374.128276=20
+L 106.589935 374.128276=20
+L 108.211454 374.128276=20
+L 109.832974 374.128276=20
+L 111.454493 374.128276=20
+L 113.076012 374.128276=20
+L 114.697532 374.128276=20
+L 116.319051 374.128276=20
+L 117.94057 374.128276=20
+L 119.562089 374.128276=20
+L 121.183609 374.128276=20
+L 122.805128 374.128276=20
+L 124.426647 374.128276=20
+L 126.048167 374.128276=20
+L 127.669686 374.128276=20
+L 129.291205 374.128276=20
+L 130.912725 374.128276=20
+L 132.534244 374.128276=20
+L 134.155763 374.128276=20
+L 135.777282 374.128276=20
+L 137.398802 374.128276=20
+L 139.020321 374.128276=20
+L 140.64184 374.128276=20
+L 142.26336 374.128276=20
+L 143.884879 374.128276=20
+L 145.506398 374.128276=20
+L 147.127918 374.128276=20
+L 148.749437 374.128276=20
+L 150.370956 374.128276=20
+L 151.992475 374.128276=20
+L 153.613995 374.128276=20
+L 155.235514 374.128276=20
+L 156.857033 374.128276=20
+L 158.478553 374.128276=20
+L 160.100072 374.128276=20
+L 161.721591 374.128276=20
+L 163.343111 374.128276=20
+L 164.96463 374.128276=20
+L 166.586149 374.128276=20
+L 168.207669 374.128276=20
+L 169.829188 374.128276=20
+L 171.450707 374.128276=20
+L 173.072226 374.128276=20
+L 174.693746 374.128276=20
+L 176.315265 374.128276=20
+L 177.936784 374.128276=20
+L 179.558304 374.128276=20
+L 181.179823 374.128276=20
+L 182.801342 374.128276=20
+L 184.422862 374.128276=20
+L 186.044381 374.128276=20
+L 187.6659 374.128276=20
+L 189.287419 374.128276=20
+L 190.908939 374.128276=20
+L 192.530458 374.128276=20
+L 194.151977 374.128276=20
+L 195.773497 374.128276=20
+L 197.395016 374.128276=20
+L 199.016535 374.128276=20
+L 200.638055 374.128276=20
+L 202.259574 374.128276=20
+L 203.881093 374.128276=20
+L 205.502612 374.128276=20
+L 207.124132 374.128276=20
+L 208.745651 374.128276=20
+L 210.36717 374.128276=20
+L 211.98869 374.128276=20
+L 213.610209 374.128276=20
+L 215.231728 374.128276=20
+L 216.853248 374.128276=20
+L 218.474767 374.128276=20
+L 220.096286 374.128276=20
+L 221.717805 374.128276=20
+L 223.339325 374.128276=20
+L 224.960844 374.128276=20
+L 226.582363 374.128276=20
+L 228.203883 374.128276=20
+L 229.825402 374.128276=20
+L 231.446921 374.128276=20
+L 233.068441 374.128276=20
+L 234.68996 374.128276=20
+L 236.311479 374.128276=20
+L 237.932999 374.128276=20
+L 239.554518 374.128276=20
+L 241.176037 374.128276=20
+L 242.797556 374.128276=20
+L 244.419076 374.128276=20
+L 246.040595 374.128276=20
+L 247.662114 374.128276=20
+L 249.283634 374.128276=20
+L 250.905153 374.128276=20
+L 252.526672 374.128276=20
+L 254.148192 374.128276=20
+L 255.769711 374.128276=20
+L 257.39123 374.128276=20
+L 259.012749 374.128276=20
+L 260.634269 374.128276=20
+L 262.255788 374.128276=20
+L 263.877307 374.128276=20
+L 265.498827 374.128276=20
+L 267.120346 374.128276=20
+L 268.741865 374.128276=20
+L 270.363385 374.128276=20
+L 271.984904 374.128276=20
+L 273.606423 374.128276=20
+L 275.227942 374.128276=20
+L 276.849462 374.128276=20
+L 278.470981 374.128276=20
+L 280.0925 374.128276=20
+L 281.71402 374.128276=20
+L 283.335539 374.128276=20
+L 284.957058 374.128276=20
+L 286.578578 374.128276=20
+L 288.200097 374.128276=20
+L 289.821616 374.128276=20
+L 291.443136 374.128276=20
+L 293.064655 374.128276=20
+L 294.686174 374.128276=20
+L 296.307693 374.128276=20
+L 297.929213 374.128276=20
+L 299.550732 374.128276=20
+L 301.172251 374.128276=20
+L 302.793771 374.128276=20
+L 304.41529 374.128276=20
+L 306.036809 374.128276=20
+L 307.658329 374.128276=20
+L 309.279848 374.128276=20
+L 310.901367 374.128276=20
+L 312.522886 374.128276=20
+L 314.144406 374.128276=20
+L 315.765925 374.128276=20
+L 317.387444 374.128276=20
+L 319.008964 374.128276=20
+L 320.630483 374.128276=20
+L 322.252002 374.128276=20
+L 323.873522 374.128276=20
+L 325.495041 374.128276=20
+L 327.11656 374.128276=20
+L 328.738079 374.128276=20
+L 330.359599 374.128276=20
+L 331.981118 374.128276=20
+L 333.602637 374.128276=20
+L 335.224157 374.128276=20
+L 336.845676 374.128276=20
+L 338.467195 374.128276=20
+L 340.088715 374.128276=20
+L 341.710234 374.128276=20
+L 343.331753 374.128276=20
+L 344.953272 374.128276=20
+L 346.574792 374.128276=20
+L 348.196311 374.128276=20
+L 349.81783 374.128276=20
+L 351.43935 374.128276=20
+L 353.060869 374.128276=20
+L 354.682388 374.128276=20
+L 356.303908 374.128276=20
+L 357.925427 374.128276=20
+L 359.546946 374.128276=20
+L 361.168466 374.128276=20
+L 362.789985 374.128276=20
+L 364.411504 374.128276=20
+L 366.033023 374.128276=20
+L 367.654543 374.128276=20
+L 369.276062 374.128276=20
+L 370.897581 374.128276=20
+L 372.519101 374.128276=20
+L 374.14062 374.128276=20
+L 375.762139 374.128276=20
+L 377.383659 374.128276=20
+L 379.005178 374.128276=20
+L 380.626697 374.128276=20
+L 382.248216 374.128276=20
+L 383.869736 374.128276=20
+L 385.491255 374.128276=20
+L 387.112774 374.128276=20
+L 388.734294 374.128276=20
+L 390.355813 374.128276=20
+L 391.977332 374.128276=20
+L 393.598852 374.128276=20
+L 395.220371 374.128276=20
+L 396.84189 374.128276=20
+L 398.463409 374.128276=20
+L 400.084929 374.128276=20
+L 401.706448 374.128276=20
+L 403.327967 374.128276=20
+L 404.949487 374.128276=20
+L 406.571006 374.128276=20
+L 408.192525 374.128276=20
+L 409.814045 374.128276=20
+L 411.435564 374.128276=20
+L 413.057083 374.128276=20
+L 414.678603 374.128276=20
+L 416.300122 374.128276=20
+L 417.921641 374.128276=20
+L 419.54316 374.128276=20
+L 421.16468 374.128276=20
+L 422.786199 374.128276=20
+L 424.407718 374.128276=20
+L 426.029238 374.128276=20
+L 427.650757 374.128276=20
+L 429.272276 374.128276=20
+L 430.893796 374.128276=20
+L 432.515315 374.128276=20
+L 434.136834 374.128276=20
+L 435.758353 374.128276=20
+L 437.379873 374.128276=20
+L 439.001392 374.128276=20
+L 440.622911 374.128276=20
+L 442.244431 374.128276=20
+L 443.86595 374.128276=20
+L 445.487469 374.128276=20
+L 447.108989 374.128276=20
+L 448.730508 374.128276=20
+L 450.352027 374.128276=20
+L 451.973546 374.128276=20
+L 453.595066 374.128276=20
+L 455.216585 374.128276=20
+L 456.838104 374.128276=20
+L 458.459624 374.128276=20
+L 460.081143 374.128276=20
+L 461.702662 374.128276=20
+L 463.324182 374.128276=20
+L 464.945701 374.128276=20
+L 466.56722 374.128276=20
+L 468.188739 374.128276=20
+L 469.810259 374.128276=20
+L 471.431778 374.128276=20
+L 473.053297 374.128276=20
+L 474.674817 374.128276=20
+L 476.296336 374.128276=20
+L 477.917855 374.128276=20
+L 479.539375 374.128276=20
+L 481.160894 374.128276=20
+L 482.782413 374.128276=20
+L 484.403933 374.128276=20
+L 486.025452 374.128276=20
+L 487.646971 374.128276=20
+L 489.26849 374.128276=20
+L 490.89001 374.128276=20
+L 492.511529 374.128276=20
+L 494.133048 374.128276=20
+L 495.754568 374.128276=20
+L 497.376087 374.128276=20
+L 498.997606 374.128276=20
+L 500.619126 374.128276=20
+L 502.240645 374.128276=20
+L 503.862164 374.128276=20
+L 505.483683 374.128276=20
+L 507.105203 374.128276=20
+L 508.726722 374.128276=20
+L 510.348241 374.128276=20
+L 511.969761 374.128276=20
+L 513.59128 374.128276=20
+L 515.212799 374.128276=20
+L 516.834319 374.128276=20
+L 518.455838 374.128276=20
+L 520.077357 374.128276=20
+L 521.698876 374.128276=20
+L 523.320396 374.128276=20
+L 524.941915 374.128276=20
+L 526.563434 374.128276=20
+L 528.184954 374.128276=20
+L 529.806473 374.128276=20
+L 531.427992 374.128276=20
+L 533.049512 374.128276=20
+L 534.671031 374.128276=20
+L 536.29255 374.128276=20
+L 537.91407 374.128276=20
+L 539.535589 374.128276=20
+L 541.157108 374.128276=20
+L 542.778627 374.128276=20
+L 544.400147 374.128276=20
+L 546.021666 374.128276=20
+L 547.643185 374.128276=20
+L 549.264705 374.128276=20
+L 550.886224 374.128276=20
+L 552.507743 374.128276=20
+L 554.129263 374.128276=20
+L 555.750782 374.128276=20
+L 557.372301 374.128276=20
+L 558.99382 374.128276=20
+L 560.61534 374.128276=20
+L 562.236859 374.128276=20
+L 563.858378 374.128276=20
+L 565.479898 374.128276=20
+L 567.101417 374.128276=20
+L 568.722936 374.128276=20
+L 570.344456 374.128276=20
+L 571.965975 374.128276=20
+L 573.587494 374.128276=20
+L 575.209013 374.128276=20
+L 576.830533 374.128276=20
+L 578.452052 374.128276=20
+L 580.073571 374.128276=20
+L 581.695091 374.128276=20
+L 583.31661 374.128276=20
+L 584.938129 374.128276=20
+L 586.559649 374.128276=20
+L 588.181168 374.128276=20
+L 589.802687 374.128276=20
+L 591.424206 374.128276=20
+L 593.045726 374.128276=20
+L 594.667245 374.128276=20
+L 596.288764 374.128276=20
+L 597.910284 374.128276=20
+L 599.531803 374.128276=20
+L 601.153322 374.128276=20
+L 602.774842 374.128276=20
+L 604.396361 374.128276=20
+L 606.01788 374.128276=20
+L 607.6394 374.128276=20
+L 609.260919 374.128276=20
+L 610.882438 374.128276=20
+L 612.503957 374.128276=20
+L 614.125477 374.128276=20
+L 615.746996 374.128276=20
+L 617.368515 374.128276=20
+L 618.990035 374.128276=20
+L 620.611554 374.128276=20
+L 622.233073 374.128276=20
+L 623.854593 374.128276=20
+L 625.476112 374.128276=20
+L 627.097631 374.128276=20
+L 628.71915 374.128276=20
+L 630.34067 374.128276=20
+L 631.962189 374.128276=20
+L 633.583708 374.128276=20
+L 635.205228 374.128276=20
+L 636.826747 374.128276=20
+L 638.448266 374.128276=20
+L 640.069786 374.128276=20
+L 641.691305 374.128276=20
+L 643.312824 374.128276=20
+L 644.934343 374.128276=20
+L 646.555863 374.128276=20
+L 648.177382 374.128276=20
+L 649.798901 374.128276=20
+L 651.420421 374.128276=20
+L 653.04194 374.128276=20
+L 654.663459 374.128276=20
+L 656.284979 374.128276=20
+L 657.906498 374.128276=20
+L 659.528017 374.128276=20
+L 661.149537 374.128276=20
+L 662.771056 374.128276=20
+L 664.392575 374.128276=20
+L 666.014094 374.128276=20
+L 667.635614 374.128276=20
+L 669.257133 374.128276=20
+L 670.878652 374.128276=20
+L 672.500172 374.128276=20
+L 674.121691 374.128276=20
+L 675.74321 374.128276=20
+L 675.74321 206.726106=20
+L 675.74321 206.726106=20
+L 674.121691 207.966122=20
+L 672.500172 208.674703=20
+L 670.878652 208.674703=20
+L 669.257133 208.674703=20
+L 667.635614 208.674703=20
+L 666.014094 208.851848=20
+L 664.392575 208.851848=20
+L 662.771056 209.028993=20
+L 661.149537 209.206138=20
+L 659.528017 209.914719=20
+L 657.906498 210.269009=20
+L 656.284979 210.446154=20
+L 654.663459 210.446154=20
+L 653.04194 210.446154=20
+L 651.420421 211.68617=20
+L 649.798901 212.394751=20
+L 648.177382 213.457622=20
+L 646.555863 214.520493=20
+L 644.934343 216.82338=20
+L 643.312824 216.82338=20
+L 641.691305 217.000525=20
+L 640.069786 218.417686=20
+L 638.448266 218.771976=20
+L 636.826747 219.126267=20
+L 635.205228 219.657702=20
+L 633.583708 220.366283=20
+L 631.962189 220.897718=20
+L 630.34067 221.074863=20
+L 628.71915 221.606299=20
+L 627.097631 222.492025=20
+L 625.476112 222.492025=20
+L 623.854593 222.66917=20
+L 622.233073 223.554896=20
+L 620.611554 223.554896=20
+L 618.990035 223.554896=20
+L 617.368515 223.554896=20
+L 615.746996 223.732041=20
+L 614.125477 226.212073=20
+L 612.503957 226.566363=20
+L 610.882438 226.743508=20
+L 609.260919 227.806379=20
+L 607.6394 227.806379=20
+L 606.01788 228.16067=20
+L 604.396361 229.223541=20
+L 602.774842 231.172137=20
+L 601.153322 233.297879=20
+L 599.531803 241.977992=20
+L 597.910284 242.332282=20
+L 596.288764 242.509427=20
+L 594.667245 243.572298=20
+L 593.045726 244.635169=20
+L 591.424206 247.823782=20
+L 589.802687 249.949524=20
+L 588.181168 253.315281=20
+L 586.559649 254.909588=20
+L 584.938129 254.909588=20
+L 583.31661 255.795314=20
+L 581.695091 256.858185=20
+L 580.073571 259.338217=20
+L 578.452052 260.932523=20
+L 576.830533 261.109668=20
+L 575.209013 261.109668=20
+L 573.587494 263.412555=20
+L 571.965975 263.766846=20
+L 570.344456 263.943991=20
+L 568.722936 267.841184=20
+L 567.101417 269.0812=20
+L 565.479898 277.052732=20
+L 563.858378 277.229877=20
+L 562.236859 277.229877=20
+L 560.61534 288.035732=20
+L 558.99382 289.275748=20
+L 557.372301 289.275748=20
+L 555.750782 289.984328=20
+L 554.129263 290.692909=20
+L 552.507743 290.692909=20
+L 550.886224 290.692909=20
+L 549.264705 291.578635=20
+L 547.643185 292.287215=20
+L 546.021666 292.287215=20
+L 544.400147 292.46436=20
+L 542.778627 293.172941=20
+L 541.157108 293.172941=20
+L 539.535589 293.172941=20
+L 537.91407 293.881522=20
+L 536.29255 294.412957=20
+L 534.671031 294.767247=20
+L 533.049512 296.715844=20
+L 531.427992 296.715844=20
+L 529.806473 296.715844=20
+L 528.184954 296.892989=20
+L 526.563434 296.892989=20
+L 524.941915 297.60157=20
+L 523.320396 297.60157=20
+L 521.698876 297.60157=20
+L 520.077357 298.487296=20
+L 518.455838 298.664441=20
+L 516.834319 298.664441=20
+L 515.212799 298.664441=20
+L 513.59128 298.841586=20
+L 511.969761 298.841586=20
+L 510.348241 298.841586=20
+L 508.726722 299.195876=20
+L 507.105203 299.373021=20
+L 505.483683 299.373021=20
+L 503.862164 300.435892=20
+L 502.240645 300.967328=20
+L 500.619126 300.967328=20
+L 498.997606 300.967328=20
+L 497.376087 301.144473=20
+L 495.754568 302.561634=20
+L 494.133048 302.561634=20
+L 492.511529 303.80165=20
+L 490.89001 304.155941=20
+L 489.26849 304.333086=20
+L 487.646971 304.510231=20
+L 486.025452 304.687376=20
+L 484.403933 304.687376=20
+L 482.782413 305.218812=20
+L 481.160894 305.218812=20
+L 479.539375 305.750247=20
+L 477.917855 305.750247=20
+L 476.296336 306.104537=20
+L 474.674817 309.116005=20
+L 473.053297 309.116005=20
+L 471.431778 309.116005=20
+L 469.810259 309.116005=20
+L 468.188739 309.116005=20
+L 466.56722 309.116005=20
+L 464.945701 309.64744=20
+L 463.324182 309.64744=20
+L 461.702662 309.64744=20
+L 460.081143 311.241747=20
+L 458.459624 313.544634=20
+L 456.838104 314.43036=20
+L 455.216585 315.847521=20
+L 453.595066 318.150408=20
+L 451.973546 318.150408=20
+L 450.352027 318.150408=20
+L 448.730508 319.036134=20
+L 447.108989 320.099004=20
+L 445.487469 320.27615=20
+L 443.86595 320.453295=20
+L 442.244431 320.453295=20
+L 440.622911 320.453295=20
+L 439.001392 320.453295=20
+L 437.379873 320.453295=20
+L 435.758353 320.63044=20
+L 434.136834 321.339021=20
+L 432.515315 321.693311=20
+L 430.893796 322.047601=20
+L 429.272276 322.047601=20
+L 427.650757 322.047601=20
+L 426.029238 322.047601=20
+L 424.407718 322.047601=20
+L 422.786199 322.579037=20
+L 421.16468 323.110472=20
+L 419.54316 323.996198=20
+L 417.921641 323.996198=20
+L 416.300122 323.996198=20
+L 414.678603 324.173343=20
+L 413.057083 324.173343=20
+L 411.435564 324.881924=20
+L 409.814045 325.236214=20
+L 408.192525 326.12194=20
+L 406.571006 326.653375=20
+L 404.949487 326.83052=20
+L 403.327967 326.83052=20
+L 401.706448 327.007665=20
+L 400.084929 327.893391=20
+L 398.463409 327.893391=20
+L 396.84189 328.601972=20
+L 395.220371 328.956262=20
+L 393.598852 329.133407=20
+L 391.977332 329.133407=20
+L 390.355813 329.664843=20
+L 388.734294 330.727714=20
+L 387.112774 331.082004=20
+L 385.491255 331.082004=20
+L 383.869736 332.144875=20
+L 382.248216 332.144875=20
+L 380.626697 332.144875=20
+L 379.005178 332.32202=20
+L 377.383659 332.499165=20
+L 375.762139 333.030601=20
+L 374.14062 333.207746=20
+L 372.519101 333.739181=20
+L 370.897581 333.916326=20
+L 369.276062 334.093472=20
+L 367.654543 334.802052=20
+L 366.033023 335.510633=20
+L 364.411504 335.687778=20
+L 362.789985 335.687778=20
+L 361.168466 335.864923=20
+L 359.546946 336.219213=20
+L 357.925427 336.219213=20
+L 356.303908 336.219213=20
+L 354.682388 336.219213=20
+L 353.060869 336.219213=20
+L 351.43935 336.219213=20
+L 349.81783 336.750649=20
+L 348.196311 336.750649=20
+L 346.574792 336.927794=20
+L 344.953272 336.927794=20
+L 343.331753 337.282084=20
+L 341.710234 337.282084=20
+L 340.088715 337.282084=20
+L 338.467195 337.282084=20
+L 336.845676 337.282084=20
+L 335.224157 337.282084=20
+L 333.602637 337.990665=20
+L 331.981118 338.344955=20
+L 330.359599 338.5221=20
+L 328.738079 338.699246=20
+L 327.11656 339.230681=20
+L 325.495041 339.230681=20
+L 323.873522 339.230681=20
+L 322.252002 339.230681=20
+L 320.630483 339.230681=20
+L 319.008964 339.230681=20
+L 317.387444 339.407826=20
+L 315.765925 339.407826=20
+L 314.144406 339.407826=20
+L 312.522886 339.407826=20
+L 310.901367 339.584971=20
+L 309.279848 339.762117=20
+L 307.658329 339.762117=20
+L 306.036809 339.939262=20
+L 304.41529 340.470697=20
+L 302.793771 340.647842=20
+L 301.172251 340.647842=20
+L 299.550732 340.647842=20
+L 297.929213 340.647842=20
+L 296.307693 341.179278=20
+L 294.686174 341.356423=20
+L 293.064655 341.356423=20
+L 291.443136 341.356423=20
+L 289.821616 341.356423=20
+L 288.200097 341.533568=20
+L 286.578578 341.533568=20
+L 284.957058 341.710713=20
+L 283.335539 341.887858=20
+L 281.71402 342.065004=20
+L 280.0925 342.242149=20
+L 278.470981 342.242149=20
+L 276.849462 342.242149=20
+L 275.227942 342.950729=20
+L 273.606423 343.30502=20
+L 271.984904 343.30502=20
+L 270.363385 343.30502=20
+L 268.741865 343.30502=20
+L 267.120346 343.30502=20
+L 265.498827 346.670778=20
+L 263.877307 346.670778=20
+L 262.255788 346.670778=20
+L 260.634269 346.670778=20
+L 259.012749 347.025068=20
+L 257.39123 347.025068=20
+L 255.769711 347.025068=20
+L 254.148192 347.025068=20
+L 252.526672 347.025068=20
+L 250.905153 347.025068=20
+L 249.283634 347.202213=20
+L 247.662114 347.202213=20
+L 246.040595 347.202213=20
+L 244.419076 347.202213=20
+L 242.797556 347.202213=20
+L 241.176037 347.202213=20
+L 239.554518 347.202213=20
+L 237.932999 347.379358=20
+L 236.311479 348.087939=20
+L 234.68996 348.087939=20
+L 233.068441 348.087939=20
+L 231.446921 348.087939=20
+L 229.825402 348.087939=20
+L 228.203883 348.087939=20
+L 226.582363 348.619374=20
+L 224.960844 348.973665=20
+L 223.339325 348.973665=20
+L 221.717805 348.973665=20
+L 220.096286 348.973665=20
+L 218.474767 350.036535=20
+L 216.853248 350.036535=20
+L 215.231728 350.390826=20
+L 213.610209 351.099406=20
+L 211.98869 351.099406=20
+L 210.36717 351.099406=20
+L 208.745651 351.276552=20
+L 207.124132 351.276552=20
+L 205.502612 351.630842=20
+L 203.881093 351.807987=20
+L 202.259574 351.985132=20
+L 200.638055 352.162277=20
+L 199.016535 352.162277=20
+L 197.395016 352.162277=20
+L 195.773497 352.870858=20
+L 194.151977 353.225148=20
+L 192.530458 353.225148=20
+L 190.908939 353.225148=20
+L 189.287419 353.225148=20
+L 187.6659 353.402293=20
+L 186.044381 354.9966=20
+L 184.422862 354.9966=20
+L 182.801342 355.35089=20
+L 181.179823 355.35089=20
+L 179.558304 355.528035=20
+L 177.936784 355.528035=20
+L 176.315265 355.528035=20
+L 174.693746 356.059471=20
+L 173.072226 356.768051=20
+L 171.450707 356.945196=20
+L 169.829188 356.945196=20
+L 168.207669 357.122342=20
+L 166.586149 357.299487=20
+L 164.96463 357.830922=20
+L 163.343111 358.362358=20
+L 161.721591 359.602374=20
+L 160.100072 360.310954=20
+L 158.478553 360.665245=20
+L 156.857033 360.665245=20
+L 155.235514 360.84239=20
+L 153.613995 360.84239=20
+L 151.992475 361.19668=20
+L 150.370956 361.550971=20
+L 148.749437 361.728116=20
+L 147.127918 361.728116=20
+L 145.506398 361.728116=20
+L 143.884879 361.728116=20
+L 142.26336 361.728116=20
+L 140.64184 361.905261=20
+L 139.020321 362.259551=20
+L 137.398802 362.436696=20
+L 135.777282 363.322422=20
+L 134.155763 363.322422=20
+L 132.534244 363.322422=20
+L 130.912725 363.322422=20
+L 129.291205 363.322422=20
+L 127.669686 363.499567=20
+L 126.048167 363.499567=20
+L 124.426647 364.031003=20
+L 122.805128 364.208148=20
+L 121.183609 364.208148=20
+L 119.562089 364.385293=20
+L 117.94057 364.562438=20
+L 116.319051 364.562438=20
+L 114.697532 365.271019=20
+L 113.076012 365.448164=20
+L 111.454493 365.625309=20
+L 109.832974 365.625309=20
+L 108.211454 365.979599=20
+L 106.589935 365.979599=20
+L 104.968416 365.979599=20
+L 103.346896 366.511035=20
+L 101.725377 366.511035=20
+L 100.103858 366.511035=20
+L 98.482338 366.511035=20
+L 96.860819 366.511035=20
+L 95.2393 366.865325=20
+L 93.617781 366.865325=20
+L 91.996261 367.04247=20
+L 90.374742 367.04247=20
+L 88.753223 367.04247=20
+L 87.131703 367.04247=20
+L 85.510184 367.04247=20
+L 83.888665 367.219615=20
+z
+" clip-path=3D"url(#p5b9f229a39)" style=3D"fill: #2ca02c; fill-opacity: 0.=
75"/>
+   </g>
+   <g id=3D"FillBetweenPolyCollection_2">
+    <path d=3D"M 83.888665 262.349684=20
+L 83.888665 367.219615=20
+L 85.510184 367.04247=20
+L 87.131703 367.04247=20
+L 88.753223 367.04247=20
+L 90.374742 367.04247=20
+L 91.996261 367.04247=20
+L 93.617781 366.865325=20
+L 95.2393 366.865325=20
+L 96.860819 366.511035=20
+L 98.482338 366.511035=20
+L 100.103858 366.511035=20
+L 101.725377 366.511035=20
+L 103.346896 366.511035=20
+L 104.968416 365.979599=20
+L 106.589935 365.979599=20
+L 108.211454 365.979599=20
+L 109.832974 365.625309=20
+L 111.454493 365.625309=20
+L 113.076012 365.448164=20
+L 114.697532 365.271019=20
+L 116.319051 364.562438=20
+L 117.94057 364.562438=20
+L 119.562089 364.385293=20
+L 121.183609 364.208148=20
+L 122.805128 364.208148=20
+L 124.426647 364.031003=20
+L 126.048167 363.499567=20
+L 127.669686 363.499567=20
+L 129.291205 363.322422=20
+L 130.912725 363.322422=20
+L 132.534244 363.322422=20
+L 134.155763 363.322422=20
+L 135.777282 363.322422=20
+L 137.398802 362.436696=20
+L 139.020321 362.259551=20
+L 140.64184 361.905261=20
+L 142.26336 361.728116=20
+L 143.884879 361.728116=20
+L 145.506398 361.728116=20
+L 147.127918 361.728116=20
+L 148.749437 361.728116=20
+L 150.370956 361.550971=20
+L 151.992475 361.19668=20
+L 153.613995 360.84239=20
+L 155.235514 360.84239=20
+L 156.857033 360.665245=20
+L 158.478553 360.665245=20
+L 160.100072 360.310954=20
+L 161.721591 359.602374=20
+L 163.343111 358.362358=20
+L 164.96463 357.830922=20
+L 166.586149 357.299487=20
+L 168.207669 357.122342=20
+L 169.829188 356.945196=20
+L 171.450707 356.945196=20
+L 173.072226 356.768051=20
+L 174.693746 356.059471=20
+L 176.315265 355.528035=20
+L 177.936784 355.528035=20
+L 179.558304 355.528035=20
+L 181.179823 355.35089=20
+L 182.801342 355.35089=20
+L 184.422862 354.9966=20
+L 186.044381 354.9966=20
+L 187.6659 353.402293=20
+L 189.287419 353.225148=20
+L 190.908939 353.225148=20
+L 192.530458 353.225148=20
+L 194.151977 353.225148=20
+L 195.773497 352.870858=20
+L 197.395016 352.162277=20
+L 199.016535 352.162277=20
+L 200.638055 352.162277=20
+L 202.259574 351.985132=20
+L 203.881093 351.807987=20
+L 205.502612 351.630842=20
+L 207.124132 351.276552=20
+L 208.745651 351.276552=20
+L 210.36717 351.099406=20
+L 211.98869 351.099406=20
+L 213.610209 351.099406=20
+L 215.231728 350.390826=20
+L 216.853248 350.036535=20
+L 218.474767 350.036535=20
+L 220.096286 348.973665=20
+L 221.717805 348.973665=20
+L 223.339325 348.973665=20
+L 224.960844 348.973665=20
+L 226.582363 348.619374=20
+L 228.203883 348.087939=20
+L 229.825402 348.087939=20
+L 231.446921 348.087939=20
+L 233.068441 348.087939=20
+L 234.68996 348.087939=20
+L 236.311479 348.087939=20
+L 237.932999 347.379358=20
+L 239.554518 347.202213=20
+L 241.176037 347.202213=20
+L 242.797556 347.202213=20
+L 244.419076 347.202213=20
+L 246.040595 347.202213=20
+L 247.662114 347.202213=20
+L 249.283634 347.202213=20
+L 250.905153 347.025068=20
+L 252.526672 347.025068=20
+L 254.148192 347.025068=20
+L 255.769711 347.025068=20
+L 257.39123 347.025068=20
+L 259.012749 347.025068=20
+L 260.634269 346.670778=20
+L 262.255788 346.670778=20
+L 263.877307 346.670778=20
+L 265.498827 346.670778=20
+L 267.120346 343.30502=20
+L 268.741865 343.30502=20
+L 270.363385 343.30502=20
+L 271.984904 343.30502=20
+L 273.606423 343.30502=20
+L 275.227942 342.950729=20
+L 276.849462 342.242149=20
+L 278.470981 342.242149=20
+L 280.0925 342.242149=20
+L 281.71402 342.065004=20
+L 283.335539 341.887858=20
+L 284.957058 341.710713=20
+L 286.578578 341.533568=20
+L 288.200097 341.533568=20
+L 289.821616 341.356423=20
+L 291.443136 341.356423=20
+L 293.064655 341.356423=20
+L 294.686174 341.356423=20
+L 296.307693 341.179278=20
+L 297.929213 340.647842=20
+L 299.550732 340.647842=20
+L 301.172251 340.647842=20
+L 302.793771 340.647842=20
+L 304.41529 340.470697=20
+L 306.036809 339.939262=20
+L 307.658329 339.762117=20
+L 309.279848 339.762117=20
+L 310.901367 339.584971=20
+L 312.522886 339.407826=20
+L 314.144406 339.407826=20
+L 315.765925 339.407826=20
+L 317.387444 339.407826=20
+L 319.008964 339.230681=20
+L 320.630483 339.230681=20
+L 322.252002 339.230681=20
+L 323.873522 339.230681=20
+L 325.495041 339.230681=20
+L 327.11656 339.230681=20
+L 328.738079 338.699246=20
+L 330.359599 338.5221=20
+L 331.981118 338.344955=20
+L 333.602637 337.990665=20
+L 335.224157 337.282084=20
+L 336.845676 337.282084=20
+L 338.467195 337.282084=20
+L 340.088715 337.282084=20
+L 341.710234 337.282084=20
+L 343.331753 337.282084=20
+L 344.953272 336.927794=20
+L 346.574792 336.927794=20
+L 348.196311 336.750649=20
+L 349.81783 336.750649=20
+L 351.43935 336.219213=20
+L 353.060869 336.219213=20
+L 354.682388 336.219213=20
+L 356.303908 336.219213=20
+L 357.925427 336.219213=20
+L 359.546946 336.219213=20
+L 361.168466 335.864923=20
+L 362.789985 335.687778=20
+L 364.411504 335.687778=20
+L 366.033023 335.510633=20
+L 367.654543 334.802052=20
+L 369.276062 334.093472=20
+L 370.897581 333.916326=20
+L 372.519101 333.739181=20
+L 374.14062 333.207746=20
+L 375.762139 333.030601=20
+L 377.383659 332.499165=20
+L 379.005178 332.32202=20
+L 380.626697 332.144875=20
+L 382.248216 332.144875=20
+L 383.869736 332.144875=20
+L 385.491255 331.082004=20
+L 387.112774 331.082004=20
+L 388.734294 330.727714=20
+L 390.355813 329.664843=20
+L 391.977332 329.133407=20
+L 393.598852 329.133407=20
+L 395.220371 328.956262=20
+L 396.84189 328.601972=20
+L 398.463409 327.893391=20
+L 400.084929 327.893391=20
+L 401.706448 327.007665=20
+L 403.327967 326.83052=20
+L 404.949487 326.83052=20
+L 406.571006 326.653375=20
+L 408.192525 326.12194=20
+L 409.814045 325.236214=20
+L 411.435564 324.881924=20
+L 413.057083 324.173343=20
+L 414.678603 324.173343=20
+L 416.300122 323.996198=20
+L 417.921641 323.996198=20
+L 419.54316 323.996198=20
+L 421.16468 323.110472=20
+L 422.786199 322.579037=20
+L 424.407718 322.047601=20
+L 426.029238 322.047601=20
+L 427.650757 322.047601=20
+L 429.272276 322.047601=20
+L 430.893796 322.047601=20
+L 432.515315 321.693311=20
+L 434.136834 321.339021=20
+L 435.758353 320.63044=20
+L 437.379873 320.453295=20
+L 439.001392 320.453295=20
+L 440.622911 320.453295=20
+L 442.244431 320.453295=20
+L 443.86595 320.453295=20
+L 445.487469 320.27615=20
+L 447.108989 320.099004=20
+L 448.730508 319.036134=20
+L 450.352027 318.150408=20
+L 451.973546 318.150408=20
+L 453.595066 318.150408=20
+L 455.216585 315.847521=20
+L 456.838104 314.43036=20
+L 458.459624 313.544634=20
+L 460.081143 311.241747=20
+L 461.702662 309.64744=20
+L 463.324182 309.64744=20
+L 464.945701 309.64744=20
+L 466.56722 309.116005=20
+L 468.188739 309.116005=20
+L 469.810259 309.116005=20
+L 471.431778 309.116005=20
+L 473.053297 309.116005=20
+L 474.674817 309.116005=20
+L 476.296336 306.104537=20
+L 477.917855 305.750247=20
+L 479.539375 305.750247=20
+L 481.160894 305.218812=20
+L 482.782413 305.218812=20
+L 484.403933 304.687376=20
+L 486.025452 304.687376=20
+L 487.646971 304.510231=20
+L 489.26849 304.333086=20
+L 490.89001 304.155941=20
+L 492.511529 303.80165=20
+L 494.133048 302.561634=20
+L 495.754568 302.561634=20
+L 497.376087 301.144473=20
+L 498.997606 300.967328=20
+L 500.619126 300.967328=20
+L 502.240645 300.967328=20
+L 503.862164 300.435892=20
+L 505.483683 299.373021=20
+L 507.105203 299.373021=20
+L 508.726722 299.195876=20
+L 510.348241 298.841586=20
+L 511.969761 298.841586=20
+L 513.59128 298.841586=20
+L 515.212799 298.664441=20
+L 516.834319 298.664441=20
+L 518.455838 298.664441=20
+L 520.077357 298.487296=20
+L 521.698876 297.60157=20
+L 523.320396 297.60157=20
+L 524.941915 297.60157=20
+L 526.563434 296.892989=20
+L 528.184954 296.892989=20
+L 529.806473 296.715844=20
+L 531.427992 296.715844=20
+L 533.049512 296.715844=20
+L 534.671031 294.767247=20
+L 536.29255 294.412957=20
+L 537.91407 293.881522=20
+L 539.535589 293.172941=20
+L 541.157108 293.172941=20
+L 542.778627 293.172941=20
+L 544.400147 292.46436=20
+L 546.021666 292.287215=20
+L 547.643185 292.287215=20
+L 549.264705 291.578635=20
+L 550.886224 290.692909=20
+L 552.507743 290.692909=20
+L 554.129263 290.692909=20
+L 555.750782 289.984328=20
+L 557.372301 289.275748=20
+L 558.99382 289.275748=20
+L 560.61534 288.035732=20
+L 562.236859 277.229877=20
+L 563.858378 277.229877=20
+L 565.479898 277.052732=20
+L 567.101417 269.0812=20
+L 568.722936 267.841184=20
+L 570.344456 263.943991=20
+L 571.965975 263.766846=20
+L 573.587494 263.412555=20
+L 575.209013 261.109668=20
+L 576.830533 261.109668=20
+L 578.452052 260.932523=20
+L 580.073571 259.338217=20
+L 581.695091 256.858185=20
+L 583.31661 255.795314=20
+L 584.938129 254.909588=20
+L 586.559649 254.909588=20
+L 588.181168 253.315281=20
+L 589.802687 249.949524=20
+L 591.424206 247.823782=20
+L 593.045726 244.635169=20
+L 594.667245 243.572298=20
+L 596.288764 242.509427=20
+L 597.910284 242.332282=20
+L 599.531803 241.977992=20
+L 601.153322 233.297879=20
+L 602.774842 231.172137=20
+L 604.396361 229.223541=20
+L 606.01788 228.16067=20
+L 607.6394 227.806379=20
+L 609.260919 227.806379=20
+L 610.882438 226.743508=20
+L 612.503957 226.566363=20
+L 614.125477 226.212073=20
+L 615.746996 223.732041=20
+L 617.368515 223.554896=20
+L 618.990035 223.554896=20
+L 620.611554 223.554896=20
+L 622.233073 223.554896=20
+L 623.854593 222.66917=20
+L 625.476112 222.492025=20
+L 627.097631 222.492025=20
+L 628.71915 221.606299=20
+L 630.34067 221.074863=20
+L 631.962189 220.897718=20
+L 633.583708 220.366283=20
+L 635.205228 219.657702=20
+L 636.826747 219.126267=20
+L 638.448266 218.771976=20
+L 640.069786 218.417686=20
+L 641.691305 217.000525=20
+L 643.312824 216.82338=20
+L 644.934343 216.82338=20
+L 646.555863 214.520493=20
+L 648.177382 213.457622=20
+L 649.798901 212.394751=20
+L 651.420421 211.68617=20
+L 653.04194 210.446154=20
+L 654.663459 210.446154=20
+L 656.284979 210.446154=20
+L 657.906498 210.269009=20
+L 659.528017 209.914719=20
+L 661.149537 209.206138=20
+L 662.771056 209.028993=20
+L 664.392575 208.851848=20
+L 666.014094 208.851848=20
+L 667.635614 208.674703=20
+L 669.257133 208.674703=20
+L 670.878652 208.674703=20
+L 672.500172 208.674703=20
+L 674.121691 207.966122=20
+L 675.74321 206.726106=20
+L 675.74321 46.232596=20
+L 675.74321 46.232596=20
+L 674.121691 47.295467=20
+L 672.500172 48.004048=20
+L 670.878652 48.712629=20
+L 669.257133 49.066919=20
+L 667.635614 49.598354=20
+L 666.014094 49.598354=20
+L 664.392575 55.798435=20
+L 662.771056 55.97558=20
+L 661.149537 57.569886=20
+L 659.528017 58.632757=20
+L 657.906498 59.341338=20
+L 656.284979 60.581354=20
+L 654.663459 60.758499=20
+L 653.04194 60.935644=20
+L 651.420421 61.112789=20
+L 649.798901 62.884241=20
+L 648.177382 63.415676=20
+L 646.555863 65.009983=20
+L 644.934343 66.249999=20
+L 643.312824 67.135725=20
+L 641.691305 67.135725=20
+L 640.069786 68.375741=20
+L 638.448266 69.084321=20
+L 636.826747 69.792902=20
+L 635.205228 71.387208=20
+L 633.583708 71.918644=20
+L 631.962189 72.272934=20
+L 630.34067 72.80437=20
+L 628.71915 73.335805=20
+L 627.097631 74.398676=20
+L 625.476112 75.107257=20
+L 623.854593 78.65016=20
+L 622.233073 80.598756=20
+L 620.611554 80.953047=20
+L 618.990035 82.193063=20
+L 617.368515 82.724498=20
+L 615.746996 82.901643=20
+L 614.125477 83.078789=20
+L 612.503957 83.433079=20
+L 610.882438 83.964514=20
+L 609.260919 84.49595=20
+L 607.6394 84.49595=20
+L 606.01788 84.85024=20
+L 604.396361 86.444546=20
+L 602.774842 88.393143=20
+L 601.153322 89.633159=20
+L 599.531803 90.34174=20
+L 597.910284 90.873175=20
+L 596.288764 91.404611=20
+L 594.667245 92.113191=20
+L 593.045726 92.998917=20
+L 591.424206 93.530353=20
+L 589.802687 94.593224=20
+L 588.181168 97.250401=20
+L 586.559649 98.844707=20
+L 584.938129 99.021852=20
+L 583.31661 99.553288=20
+L 581.695091 99.907578=20
+L 580.073571 100.970449=20
+L 578.452052 109.827707=20
+L 576.830533 110.536287=20
+L 575.209013 110.890578=20
+L 573.587494 111.067723=20
+L 571.965975 111.776303=20
+L 570.344456 112.307739=20
+L 568.722936 112.839174=20
+L 567.101417 112.839174=20
+L 565.479898 114.256336=20
+L 563.858378 114.610626=20
+L 562.236859 114.964916=20
+L 560.61534 115.850642=20
+L 558.99382 116.027787=20
+L 557.372301 116.382077=20
+L 555.750782 116.559223=20
+L 554.129263 117.976384=20
+L 552.507743 117.976384=20
+L 550.886224 119.57069=20
+L 549.264705 122.759303=20
+L 547.643185 126.125061=20
+L 546.021666 126.833642=20
+L 544.400147 127.187932=20
+L 542.778627 128.605093=20
+L 541.157108 129.136529=20
+L 539.535589 129.313674=20
+L 537.91407 129.313674=20
+L 536.29255 130.730835=20
+L 534.671031 134.628028=20
+L 533.049512 135.336609=20
+L 531.427992 136.04519=20
+L 529.806473 136.222335=20
+L 528.184954 136.75377=20
+L 526.563434 137.285206=20
+L 524.941915 138.170931=20
+L 523.320396 139.056657=20
+L 521.698876 139.410947=20
+L 520.077357 139.765238=20
+L 518.455838 140.828109=20
+L 516.834319 141.005254=20
+L 515.212799 141.182399=20
+L 513.59128 141.713834=20
+L 511.969761 142.068125=20
+L 510.348241 142.422415=20
+L 508.726722 143.485286=20
+L 507.105203 144.016721=20
+L 505.483683 145.079592=20
+L 503.862164 146.851044=20
+L 502.240645 151.102528=20
+L 500.619126 151.811108=20
+L 498.997606 151.811108=20
+L 497.376087 155.176866=20
+L 495.754568 155.531156=20
+L 494.133048 156.062592=20
+L 492.511529 156.771173=20
+L 490.89001 157.302608=20
+L 489.26849 157.834043=20
+L 487.646971 158.011189=20
+L 486.025452 161.554092=20
+L 484.403933 162.262672=20
+L 482.782413 162.794108=20
+L 481.160894 163.502688=20
+L 479.539375 163.856979=20
+L 477.917855 167.045591=20
+L 476.296336 168.462753=20
+L 474.674817 169.171333=20
+L 473.053297 173.422817=20
+L 471.431778 173.422817=20
+L 469.810259 174.485688=20
+L 468.188739 174.839978=20
+L 466.56722 177.32001=20
+L 464.945701 178.205736=20
+L 463.324182 179.268607=20
+L 461.702662 180.862913=20
+L 460.081143 181.040059=20
+L 458.459624 184.228671=20
+L 456.838104 185.645833=20
+L 455.216585 186.885849=20
+L 453.595066 187.594429=20
+L 451.973546 188.6573=20
+L 450.352027 188.834445=20
+L 448.730508 189.720171=20
+L 447.108989 190.428752=20
+L 445.487469 191.845913=20
+L 443.86595 193.263074=20
+L 442.244431 194.325945=20
+L 440.622911 196.805977=20
+L 439.001392 196.983122=20
+L 437.379873 196.983122=20
+L 435.758353 198.045993=20
+L 434.136834 199.817445=20
+L 432.515315 200.703171=20
+L 430.893796 201.766042=20
+L 429.272276 206.371816=20
+L 427.650757 206.371816=20
+L 426.029238 207.080396=20
+L 424.407718 207.434687=20
+L 422.786199 208.320412=20
+L 421.16468 208.497558=20
+L 419.54316 208.851848=20
+L 417.921641 209.560428=20
+L 416.300122 209.560428=20
+L 414.678603 209.737574=20
+L 413.057083 209.914719=20
+L 411.435564 209.914719=20
+L 409.814045 210.269009=20
+L 408.192525 211.33188=20
+L 406.571006 212.394751=20
+L 404.949487 212.749041=20
+L 403.327967 213.457622=20
+L 401.706448 215.051928=20
+L 400.084929 215.760509=20
+L 398.463409 215.937654=20
+L 396.84189 216.114799=20
+L 395.220371 216.291944=20
+L 393.598852 216.646235=20
+L 391.977332 217.17767=20
+L 390.355813 217.17767=20
+L 388.734294 217.886251=20
+L 387.112774 218.240541=20
+L 385.491255 218.417686=20
+L 383.869736 219.303412=20
+L 382.248216 219.303412=20
+L 380.626697 219.480557=20
+L 379.005178 219.657702=20
+L 377.383659 220.366283=20
+L 375.762139 221.606299=20
+L 374.14062 222.31488=20
+L 372.519101 223.02346=20
+L 370.897581 223.200605=20
+L 369.276062 223.732041=20
+L 367.654543 224.972057=20
+L 366.033023 225.680637=20
+L 364.411504 225.680637=20
+L 362.789985 226.389218=20
+L 361.168466 226.566363=20
+L 359.546946 227.097799=20
+L 357.925427 227.097799=20
+L 356.303908 227.097799=20
+L 354.682388 227.097799=20
+L 353.060869 227.097799=20
+L 351.43935 227.274944=20
+L 349.81783 227.274944=20
+L 348.196311 227.274944=20
+L 346.574792 227.629234=20
+L 344.953272 227.806379=20
+L 343.331753 228.16067=20
+L 341.710234 228.16067=20
+L 340.088715 228.51496=20
+L 338.467195 228.86925=20
+L 336.845676 229.046395=20
+L 335.224157 229.046395=20
+L 333.602637 229.046395=20
+L 331.981118 229.046395=20
+L 330.359599 229.400686=20
+L 328.738079 230.109266=20
+L 327.11656 230.286411=20
+L 325.495041 230.286411=20
+L 323.873522 230.463557=20
+L 322.252002 230.640702=20
+L 320.630483 230.640702=20
+L 319.008964 231.172137=20
+L 317.387444 231.526428=20
+L 315.765925 231.526428=20
+L 314.144406 231.526428=20
+L 312.522886 231.526428=20
+L 310.901367 231.703573=20
+L 309.279848 232.057863=20
+L 307.658329 232.057863=20
+L 306.036809 232.057863=20
+L 304.41529 232.589298=20
+L 302.793771 232.766444=20
+L 301.172251 232.766444=20
+L 299.550732 232.766444=20
+L 297.929213 232.766444=20
+L 296.307693 232.943589=20
+L 294.686174 233.475024=20
+L 293.064655 233.475024=20
+L 291.443136 233.829315=20
+L 289.821616 234.00646=20
+L 288.200097 234.183605=20
+L 286.578578 234.183605=20
+L 284.957058 234.36075=20
+L 283.335539 234.36075=20
+L 281.71402 234.537895=20
+L 280.0925 234.537895=20
+L 278.470981 234.892185=20
+L 276.849462 235.069331=20
+L 275.227942 235.955056=20
+L 273.606423 236.309347=20
+L 271.984904 236.840782=20
+L 270.363385 236.840782=20
+L 268.741865 236.840782=20
+L 267.120346 237.017927=20
+L 265.498827 237.195072=20
+L 263.877307 237.195072=20
+L 262.255788 237.195072=20
+L 260.634269 237.195072=20
+L 259.012749 237.195072=20
+L 257.39123 237.372218=20
+L 255.769711 237.372218=20
+L 254.148192 237.372218=20
+L 252.526672 237.549363=20
+L 250.905153 237.549363=20
+L 249.283634 237.549363=20
+L 247.662114 237.726508=20
+L 246.040595 237.726508=20
+L 244.419076 237.726508=20
+L 242.797556 238.080798=20
+L 241.176037 238.612234=20
+L 239.554518 238.789379=20
+L 237.932999 238.789379=20
+L 236.311479 238.789379=20
+L 234.68996 238.966524=20
+L 233.068441 238.966524=20
+L 231.446921 238.966524=20
+L 229.825402 239.143669=20
+L 228.203883 239.320814=20
+L 226.582363 239.85225=20
+L 224.960844 240.20654=20
+L 223.339325 240.383685=20
+L 221.717805 240.56083=20
+L 220.096286 240.915121=20
+L 218.474767 241.092266=20
+L 216.853248 241.446556=20
+L 215.231728 242.155137=20
+L 213.610209 242.332282=20
+L 211.98869 242.332282=20
+L 210.36717 242.509427=20
+L 208.745651 242.863717=20
+L 207.124132 242.863717=20
+L 205.502612 243.040863=20
+L 203.881093 243.572298=20
+L 202.259574 243.572298=20
+L 200.638055 243.926588=20
+L 199.016535 244.103733=20
+L 197.395016 244.103733=20
+L 195.773497 244.458024=20
+L 194.151977 244.458024=20
+L 192.530458 244.635169=20
+L 190.908939 244.812314=20
+L 189.287419 244.812314=20
+L 187.6659 245.166604=20
+L 186.044381 245.34375=20
+L 184.422862 245.69804=20
+L 182.801342 245.875185=20
+L 181.179823 245.875185=20
+L 179.558304 247.115201=20
+L 177.936784 247.292346=20
+L 176.315265 247.292346=20
+L 174.693746 247.823782=20
+L 173.072226 248.178072=20
+L 171.450707 248.178072=20
+L 169.829188 248.355217=20
+L 168.207669 248.355217=20
+L 166.586149 248.355217=20
+L 164.96463 248.886653=20
+L 163.343111 249.063798=20
+L 161.721591 249.418088=20
+L 160.100072 249.595233=20
+L 158.478553 249.772378=20
+L 156.857033 250.126669=20
+L 155.235514 250.303814=20
+L 153.613995 250.835249=20
+L 151.992475 250.835249=20
+L 150.370956 250.835249=20
+L 148.749437 251.366685=20
+L 147.127918 251.89812=20
+L 145.506398 251.89812=20
+L 143.884879 252.252411=20
+L 142.26336 252.252411=20
+L 140.64184 252.252411=20
+L 139.020321 253.315281=20
+L 137.398802 253.669572=20
+L 135.777282 254.201007=20
+L 134.155763 254.378152=20
+L 132.534244 254.378152=20
+L 130.912725 254.732443=20
+L 129.291205 254.909588=20
+L 127.669686 255.086733=20
+L 126.048167 255.263878=20
+L 124.426647 255.795314=20
+L 122.805128 256.326749=20
+L 121.183609 256.326749=20
+L 119.562089 256.503894=20
+L 117.94057 257.212475=20
+L 116.319051 257.38962=20
+L 114.697532 257.38962=20
+L 113.076012 257.921055=20
+L 111.454493 258.983926=20
+L 109.832974 258.983926=20
+L 108.211454 259.161072=20
+L 106.589935 259.338217=20
+L 104.968416 259.692507=20
+L 103.346896 259.869652=20
+L 101.725377 260.046797=20
+L 100.103858 260.223942=20
+L 98.482338 260.401088=20
+L 96.860819 260.578233=20
+L 95.2393 260.932523=20
+L 93.617781 261.641104=20
+L 91.996261 261.641104=20
+L 90.374742 261.818249=20
+L 88.753223 261.995394=20
+L 87.131703 261.995394=20
+L 85.510184 262.172539=20
+L 83.888665 262.349684=20
+z
+" clip-path=3D"url(#p5b9f229a39)" style=3D"fill: #d62728; fill-opacity: 0.=
75"/>
+   </g>
+   <g id=3D"matplotlib.axis_1">
+    <g id=3D"xtick_1">
+     <g id=3D"line2d_1">
+      <path d=3D"M 67.673472 374.128276=20
+L 67.673472 29.837812=20
+" clip-path=3D"url(#p5b9f229a39)" style=3D"fill: none; stroke-dasharray: 2=
.96,1.28; stroke-dashoffset: 0; stroke: #b0b0b0; stroke-opacity: 0.5; strok=
e-width: 0.8"/>
+     </g>
+     <g id=3D"line2d_2">
+      <defs>
+       <path id=3D"m956585b569" d=3D"M 0 0=20
+L 0 3.5=20
+" style=3D"stroke: #000000; stroke-width: 0.8"/>
+      </defs>
+      <g>
+       <use xlink:href=3D"#m956585b569" x=3D"67.673472" y=3D"374.128276" s=
tyle=3D"stroke: #000000; stroke-width: 0.8"/>
+      </g>
+     </g>
+     <g id=3D"text_1">
+      <!-- Sep -->
+      <g transform=3D"translate(50.309049 397.133716) rotate(-30) scale(0.=
1 -0.1)">
+       <defs>
+        <path id=3D"DejaVuSans-53" d=3D"M 3425 4513=20
+L 3425 3897=20
+Q 3066 4069 2747 4153=20
+Q 2428 4238 2131 4238=20
+Q 1616 4238 1336 4038=20
+Q 1056 3838 1056 3469=20
+Q 1056 3159 1242 3001=20
+Q 1428 2844 1947 2747=20
+L 2328 2669=20
+Q 3034 2534 3370 2195=20
+Q 3706 1856 3706 1288=20
+Q 3706 609 3251 259=20
+Q 2797 -91 1919 -91=20
+Q 1588 -91 1214 -16=20
+Q 841 59 441 206=20
+L 441 856=20
+Q 825 641 1194 531=20
+Q 1563 422 1919 422=20
+Q 2459 422 2753 634=20
+Q 3047 847 3047 1241=20
+Q 3047 1584 2836 1778=20
+Q 2625 1972 2144 2069=20
+L 1759 2144=20
+Q 1053 2284 737 2584=20
+Q 422 2884 422 3419=20
+Q 422 4038 858 4394=20
+Q 1294 4750 2059 4750=20
+Q 2388 4750 2728 4690=20
+Q 3069 4631 3425 4513=20
+z
+" transform=3D"scale(0.015625)"/>
+        <path id=3D"DejaVuSans-65" d=3D"M 3597 1894=20
+L 3597 1613=20
+L 953 1613=20
+Q 991 1019 1311 708=20
+Q 1631 397 2203 397=20
+Q 2534 397 2845 478=20
+Q 3156 559 3463 722=20
+L 3463 178=20
+Q 3153 47 2828 -22=20
+Q 2503 -91 2169 -91=20
+Q 1331 -91 842 396=20
+Q 353 884 353 1716=20
+Q 353 2575 817 3079=20
+Q 1281 3584 2069 3584=20
+Q 2775 3584 3186 3129=20
+Q 3597 2675 3597 1894=20
+z
+M 3022 2063=20
+Q 3016 2534 2758 2815=20
+Q 2500 3097 2075 3097=20
+Q 1594 3097 1305 2825=20
+Q 1016 2553 972 2059=20
+L 3022 2063=20
+z
+" transform=3D"scale(0.015625)"/>
+        <path id=3D"DejaVuSans-70" d=3D"M 1159 525=20
+L 1159 -1331=20
+L 581 -1331=20
+L 581 3500=20
+L 1159 3500=20
+L 1159 2969=20
+Q 1341 3281 1617 3432=20
+Q 1894 3584 2278 3584=20
+Q 2916 3584 3314 3078=20
+Q 3713 2572 3713 1747=20
+Q 3713 922 3314 415=20
+Q 2916 -91 2278 -91=20
+Q 1894 -91 1617 61=20
+Q 1341 213 1159 525=20
+z
+M 3116 1747=20
+Q 3116 2381 2855 2742=20
+Q 2594 3103 2138 3103=20
+Q 1681 3103 1420 2742=20
+Q 1159 2381 1159 1747=20
+Q 1159 1113 1420 752=20
+Q 1681 391 2138 391=20
+Q 2594 391 2855 752=20
+Q 3116 1113 3116 1747=20
+z
+" transform=3D"scale(0.015625)"/>
+       </defs>
+       <use xlink:href=3D"#DejaVuSans-53"/>
+       <use xlink:href=3D"#DejaVuSans-65" transform=3D"translate(63.476562=
 0)"/>
+       <use xlink:href=3D"#DejaVuSans-70" transform=3D"translate(125 0)"/>
+      </g>
+     </g>
+    </g>
+    <g id=3D"xtick_2">
+     <g id=3D"line2d_3">
+      <path d=3D"M 166.586149 374.128276=20
+L 166.586149 29.837812=20
+" clip-path=3D"url(#p5b9f229a39)" style=3D"fill: none; stroke-dasharray: 2=
.96,1.28; stroke-dashoffset: 0; stroke: #b0b0b0; stroke-opacity: 0.5; strok=
e-width: 0.8"/>
+     </g>
+     <g id=3D"line2d_4">
+      <g>
+       <use xlink:href=3D"#m956585b569" x=3D"166.586149" y=3D"374.128276" =
style=3D"stroke: #000000; stroke-width: 0.8"/>
+      </g>
+     </g>
+     <g id=3D"text_2">
+      <!-- Nov -->
+      <g transform=3D"translate(148.642572 397.468091) rotate(-30) scale(0=
.1 -0.1)">
+       <defs>
+        <path id=3D"DejaVuSans-4e" d=3D"M 628 4666=20
+L 1478 4666=20
+L 3547 763=20
+L 3547 4666=20
+L 4159 4666=20
+L 4159 0=20
+L 3309 0=20
+L 1241 3903=20
+L 1241 0=20
+L 628 0=20
+L 628 4666=20
+z
+" transform=3D"scale(0.015625)"/>
+        <path id=3D"DejaVuSans-6f" d=3D"M 1959 3097=20
+Q 1497 3097 1228 2736=20
+Q 959 2375 959 1747=20
+Q 959 1119 1226 758=20
+Q 1494 397 1959 397=20
+Q 2419 397 2687 759=20
+Q 2956 1122 2956 1747=20
+Q 2956 2369 2687 2733=20
+Q 2419 3097 1959 3097=20
+z
+M 1959 3584=20
+Q 2709 3584 3137 3096=20
+Q 3566 2609 3566 1747=20
+Q 3566 888 3137 398=20
+Q 2709 -91 1959 -91=20
+Q 1206 -91 779 398=20
+Q 353 888 353 1747=20
+Q 353 2609 779 3096=20
+Q 1206 3584 1959 3584=20
+z
+" transform=3D"scale(0.015625)"/>
+        <path id=3D"DejaVuSans-76" d=3D"M 191 3500=20
+L 800 3500=20
+L 1894 563=20
+L 2988 3500=20
+L 3597 3500=20
+L 2284 0=20
+L 1503 0=20
+L 191 3500=20
+z
+" transform=3D"scale(0.015625)"/>
+       </defs>
+       <use xlink:href=3D"#DejaVuSans-4e"/>
+       <use xlink:href=3D"#DejaVuSans-6f" transform=3D"translate(74.804688=
 0)"/>
+       <use xlink:href=3D"#DejaVuSans-76" transform=3D"translate(135.98632=
8 0)"/>
+      </g>
+     </g>
+    </g>
+    <g id=3D"xtick_3">
+     <g id=3D"line2d_5">
+      <path d=3D"M 265.498827 374.128276=20
+L 265.498827 29.837812=20
+" clip-path=3D"url(#p5b9f229a39)" style=3D"fill: none; stroke-dasharray: 2=
.96,1.28; stroke-dashoffset: 0; stroke: #b0b0b0; stroke-opacity: 0.5; strok=
e-width: 0.8"/>
+     </g>
+     <g id=3D"line2d_6">
+      <g>
+       <use xlink:href=3D"#m956585b569" x=3D"265.498827" y=3D"374.128276" =
style=3D"stroke: #000000; stroke-width: 0.8"/>
+      </g>
+     </g>
+     <g id=3D"text_3">
+      <!-- 2026 -->
+      <g transform=3D"translate(242.418636 400.433716) rotate(-30) scale(0=
.1 -0.1)">
+       <defs>
+        <path id=3D"DejaVuSans-32" d=3D"M 1228 531=20
+L 3431 531=20
+L 3431 0=20
+L 469 0=20
+L 469 531=20
+Q 828 903 1448 1529=20
+Q 2069 2156 2228 2338=20
+Q 2531 2678 2651 2914=20
+Q 2772 3150 2772 3378=20
+Q 2772 3750 2511 3984=20
+Q 2250 4219 1831 4219=20
+Q 1534 4219 1204 4116=20
+Q 875 4013 500 3803=20
+L 500 4441=20
+Q 881 4594 1212 4672=20
+Q 1544 4750 1819 4750=20
+Q 2544 4750 2975 4387=20
+Q 3406 4025 3406 3419=20
+Q 3406 3131 3298 2873=20
+Q 3191 2616 2906 2266=20
+Q 2828 2175 2409 1742=20
+Q 1991 1309 1228 531=20
+z
+" transform=3D"scale(0.015625)"/>
+        <path id=3D"DejaVuSans-30" d=3D"M 2034 4250=20
+Q 1547 4250 1301 3770=20
+Q 1056 3291 1056 2328=20
+Q 1056 1369 1301 889=20
+Q 1547 409 2034 409=20
+Q 2525 409 2770 889=20
+Q 3016 1369 3016 2328=20
+Q 3016 3291 2770 3770=20
+Q 2525 4250 2034 4250=20
+z
+M 2034 4750=20
+Q 2819 4750 3233 4129=20
+Q 3647 3509 3647 2328=20
+Q 3647 1150 3233 529=20
+Q 2819 -91 2034 -91=20
+Q 1250 -91 836 529=20
+Q 422 1150 422 2328=20
+Q 422 3509 836 4129=20
+Q 1250 4750 2034 4750=20
+z
+" transform=3D"scale(0.015625)"/>
+        <path id=3D"DejaVuSans-36" d=3D"M 2113 2584=20
+Q 1688 2584 1439 2293=20
+Q 1191 2003 1191 1497=20
+Q 1191 994 1439 701=20
+Q 1688 409 2113 409=20
+Q 2538 409 2786 701=20
+Q 3034 994 3034 1497=20
+Q 3034 2003 2786 2293=20
+Q 2538 2584 2113 2584=20
+z
+M 3366 4563=20
+L 3366 3988=20
+Q 3128 4100 2886 4159=20
+Q 2644 4219 2406 4219=20
+Q 1781 4219 1451 3797=20
+Q 1122 3375 1075 2522=20
+Q 1259 2794 1537 2939=20
+Q 1816 3084 2150 3084=20
+Q 2853 3084 3261 2657=20
+Q 3669 2231 3669 1497=20
+Q 3669 778 3244 343=20
+Q 2819 -91 2113 -91=20
+Q 1303 -91 875 529=20
+Q 447 1150 447 2328=20
+Q 447 3434 972 4092=20
+Q 1497 4750 2381 4750=20
+Q 2619 4750 2861 4703=20
+Q 3103 4656 3366 4563=20
+z
+" transform=3D"scale(0.015625)"/>
+       </defs>
+       <use xlink:href=3D"#DejaVuSans-32"/>
+       <use xlink:href=3D"#DejaVuSans-30" transform=3D"translate(63.623047=
 0)"/>
+       <use xlink:href=3D"#DejaVuSans-32" transform=3D"translate(127.24609=
4 0)"/>
+       <use xlink:href=3D"#DejaVuSans-36" transform=3D"translate(190.86914=
1 0)"/>
+      </g>
+     </g>
+    </g>
+    <g id=3D"xtick_4">
+     <g id=3D"line2d_7">
+      <path d=3D"M 361.168466 374.128276=20
+L 361.168466 29.837812=20
+" clip-path=3D"url(#p5b9f229a39)" style=3D"fill: none; stroke-dasharray: 2=
.96,1.28; stroke-dashoffset: 0; stroke: #b0b0b0; stroke-opacity: 0.5; strok=
e-width: 0.8"/>
+     </g>
+     <g id=3D"line2d_8">
+      <g>
+       <use xlink:href=3D"#m956585b569" x=3D"361.168466" y=3D"374.128276" =
style=3D"stroke: #000000; stroke-width: 0.8"/>
+      </g>
+     </g>
+     <g id=3D"text_4">
+      <!-- Mar -->
+      <g transform=3D"translate(343.789158 397.14231) rotate(-30) scale(0.=
1 -0.1)">
+       <defs>
+        <path id=3D"DejaVuSans-4d" d=3D"M 628 4666=20
+L 1569 4666=20
+L 2759 1491=20
+L 3956 4666=20
+L 4897 4666=20
+L 4897 0=20
+L 4281 0=20
+L 4281 4097=20
+L 3078 897=20
+L 2444 897=20
+L 1241 4097=20
+L 1241 0=20
+L 628 0=20
+L 628 4666=20
+z
+" transform=3D"scale(0.015625)"/>
+        <path id=3D"DejaVuSans-61" d=3D"M 2194 1759=20
+Q 1497 1759 1228 1600=20
+Q 959 1441 959 1056=20
+Q 959 750 1161 570=20
+Q 1363 391 1709 391=20
+Q 2188 391 2477 730=20
+Q 2766 1069 2766 1631=20
+L 2766 1759=20
+L 2194 1759=20
+z
+M 3341 1997=20
+L 3341 0=20
+L 2766 0=20
+L 2766 531=20
+Q 2569 213 2275 61=20
+Q 1981 -91 1556 -91=20
+Q 1019 -91 701 211=20
+Q 384 513 384 1019=20
+Q 384 1609 779 1909=20
+Q 1175 2209 1959 2209=20
+L 2766 2209=20
+L 2766 2266=20
+Q 2766 2663 2505 2880=20
+Q 2244 3097 1772 3097=20
+Q 1472 3097 1187 3025=20
+Q 903 2953 641 2809=20
+L 641 3341=20
+Q 956 3463 1253 3523=20
+Q 1550 3584 1831 3584=20
+Q 2591 3584 2966 3190=20
+Q 3341 2797 3341 1997=20
+z
+" transform=3D"scale(0.015625)"/>
+        <path id=3D"DejaVuSans-72" d=3D"M 2631 2963=20
+Q 2534 3019 2420 3045=20
+Q 2306 3072 2169 3072=20
+Q 1681 3072 1420 2755=20
+Q 1159 2438 1159 1844=20
+L 1159 0=20
+L 581 0=20
+L 581 3500=20
+L 1159 3500=20
+L 1159 2956=20
+Q 1341 3275 1631 3429=20
+Q 1922 3584 2338 3584=20
+Q 2397 3584 2469 3576=20
+Q 2541 3569 2628 3553=20
+L 2631 2963=20
+z
+" transform=3D"scale(0.015625)"/>
+       </defs>
+       <use xlink:href=3D"#DejaVuSans-4d"/>
+       <use xlink:href=3D"#DejaVuSans-61" transform=3D"translate(86.279297=
 0)"/>
+       <use xlink:href=3D"#DejaVuSans-72" transform=3D"translate(147.55859=
4 0)"/>
+      </g>
+     </g>
+    </g>
+    <g id=3D"xtick_5">
+     <g id=3D"line2d_9">
+      <path d=3D"M 460.081143 374.128276=20
+L 460.081143 29.837812=20
+" clip-path=3D"url(#p5b9f229a39)" style=3D"fill: none; stroke-dasharray: 2=
.96,1.28; stroke-dashoffset: 0; stroke: #b0b0b0; stroke-opacity: 0.5; strok=
e-width: 0.8"/>
+     </g>
+     <g id=3D"line2d_10">
+      <g>
+       <use xlink:href=3D"#m956585b569" x=3D"460.081143" y=3D"374.128276" =
style=3D"stroke: #000000; stroke-width: 0.8"/>
+      </g>
+     </g>
+     <g id=3D"text_5">
+      <!-- May -->
+      <g transform=3D"translate(441.136224 398.046216) rotate(-30) scale(0=
.1 -0.1)">
+       <defs>
+        <path id=3D"DejaVuSans-79" d=3D"M 2059 -325=20
+Q 1816 -950 1584 -1140=20
+Q 1353 -1331 966 -1331=20
+L 506 -1331=20
+L 506 -850=20
+L 844 -850=20
+Q 1081 -850 1212 -737=20
+Q 1344 -625 1503 -206=20
+L 1606 56=20
+L 191 3500=20
+L 800 3500=20
+L 1894 763=20
+L 2988 3500=20
+L 3597 3500=20
+L 2059 -325=20
+z
+" transform=3D"scale(0.015625)"/>
+       </defs>
+       <use xlink:href=3D"#DejaVuSans-4d"/>
+       <use xlink:href=3D"#DejaVuSans-61" transform=3D"translate(86.279297=
 0)"/>
+       <use xlink:href=3D"#DejaVuSans-79" transform=3D"translate(147.55859=
4 0)"/>
+      </g>
+     </g>
+    </g>
+    <g id=3D"xtick_6">
+     <g id=3D"line2d_11">
+      <path d=3D"M 558.99382 374.128276=20
+L 558.99382 29.837812=20
+" clip-path=3D"url(#p5b9f229a39)" style=3D"fill: none; stroke-dasharray: 2=
.96,1.28; stroke-dashoffset: 0; stroke: #b0b0b0; stroke-opacity: 0.5; strok=
e-width: 0.8"/>
+     </g>
+     <g id=3D"line2d_12">
+      <g>
+       <use xlink:href=3D"#m956585b569" x=3D"558.99382" y=3D"374.128276" s=
tyle=3D"stroke: #000000; stroke-width: 0.8"/>
+      </g>
+     </g>
+     <g id=3D"text_6">
+      <!-- Jul -->
+      <g transform=3D"translate(547.504839 393.741529) rotate(-30) scale(0=
.1 -0.1)">
+       <defs>
+        <path id=3D"DejaVuSans-4a" d=3D"M 628 4666=20
+L 1259 4666=20
+L 1259 325=20
+Q 1259 -519 939 -900=20
+Q 619 -1281 -91 -1281=20
+L -331 -1281=20
+L -331 -750=20
+L -134 -750=20
+Q 284 -750 456 -515=20
+Q 628 -281 628 325=20
+L 628 4666=20
+z
+" transform=3D"scale(0.015625)"/>
+        <path id=3D"DejaVuSans-75" d=3D"M 544 1381=20
+L 544 3500=20
+L 1119 3500=20
+L 1119 1403=20
+Q 1119 906 1312 657=20
+Q 1506 409 1894 409=20
+Q 2359 409 2629 706=20
+Q 2900 1003 2900 1516=20
+L 2900 3500=20
+L 3475 3500=20
+L 3475 0=20
+L 2900 0=20
+L 2900 538=20
+Q 2691 219 2414 64=20
+Q 2138 -91 1772 -91=20
+Q 1169 -91 856 284=20
+Q 544 659 544 1381=20
+z
+M 1991 3584=20
+L 1991 3584=20
+z
+" transform=3D"scale(0.015625)"/>
+        <path id=3D"DejaVuSans-6c" d=3D"M 603 4863=20
+L 1178 4863=20
+L 1178 0=20
+L 603 0=20
+L 603 4863=20
+z
+" transform=3D"scale(0.015625)"/>
+       </defs>
+       <use xlink:href=3D"#DejaVuSans-4a"/>
+       <use xlink:href=3D"#DejaVuSans-75" transform=3D"translate(29.492188=
 0)"/>
+       <use xlink:href=3D"#DejaVuSans-6c" transform=3D"translate(92.871094=
 0)"/>
+      </g>
+     </g>
+    </g>
+    <g id=3D"xtick_7">
+     <g id=3D"line2d_13">
+      <path d=3D"M 659.528017 374.128276=20
+L 659.528017 29.837812=20
+" clip-path=3D"url(#p5b9f229a39)" style=3D"fill: none; stroke-dasharray: 2=
.96,1.28; stroke-dashoffset: 0; stroke: #b0b0b0; stroke-opacity: 0.5; strok=
e-width: 0.8"/>
+     </g>
+     <g id=3D"line2d_14">
+      <g>
+       <use xlink:href=3D"#m956585b569" x=3D"659.528017" y=3D"374.128276" =
style=3D"stroke: #000000; stroke-width: 0.8"/>
+      </g>
+     </g>
+     <g id=3D"text_7">
+      <!-- Sep -->
+      <g transform=3D"translate(642.163595 397.133716) rotate(-30) scale(0=
.1 -0.1)">
+       <use xlink:href=3D"#DejaVuSans-53"/>
+       <use xlink:href=3D"#DejaVuSans-65" transform=3D"translate(63.476562=
 0)"/>
+       <use xlink:href=3D"#DejaVuSans-70" transform=3D"translate(125 0)"/>
+      </g>
+     </g>
+    </g>
+    <g id=3D"text_8">
+     <!-- Date -->
+     <g transform=3D"translate(366.670078 414.59306) scale(0.11 -0.11)">
+      <defs>
+       <path id=3D"DejaVuSans-44" d=3D"M 1259 4147=20
+L 1259 519=20
+L 2022 519=20
+Q 2988 519 3436 956=20
+Q 3884 1394 3884 2338=20
+Q 3884 3275 3436 3711=20
+Q 2988 4147 2022 4147=20
+L 1259 4147=20
+z
+M 628 4666=20
+L 1925 4666=20
+Q 3281 4666 3915 4102=20
+Q 4550 3538 4550 2338=20
+Q 4550 1131 3912 565=20
+Q 3275 0 1925 0=20
+L 628 0=20
+L 628 4666=20
+z
+" transform=3D"scale(0.015625)"/>
+       <path id=3D"DejaVuSans-74" d=3D"M 1172 4494=20
+L 1172 3500=20
+L 2356 3500=20
+L 2356 3053=20
+L 1172 3053=20
+L 1172 1153=20
+Q 1172 725 1289 603=20
+Q 1406 481 1766 481=20
+L 2356 481=20
+L 2356 0=20
+L 1766 0=20
+Q 1100 0 847 248=20
+Q 594 497 594 1153=20
+L 594 3053=20
+L 172 3053=20
+L 172 3500=20
+L 594 3500=20
+L 594 4494=20
+L 1172 4494=20
+z
+" transform=3D"scale(0.015625)"/>
+      </defs>
+      <use xlink:href=3D"#DejaVuSans-44"/>
+      <use xlink:href=3D"#DejaVuSans-61" transform=3D"translate(77.001953 =
0)"/>
+      <use xlink:href=3D"#DejaVuSans-74" transform=3D"translate(138.28125 =
0)"/>
+      <use xlink:href=3D"#DejaVuSans-65" transform=3D"translate(177.490234=
 0)"/>
+     </g>
+    </g>
+   </g>
+   <g id=3D"matplotlib.axis_2">
+    <g id=3D"ytick_1">
+     <g id=3D"line2d_15">
+      <path d=3D"M 54.295938 374.128276=20
+L 705.335938 374.128276=20
+" clip-path=3D"url(#p5b9f229a39)" style=3D"fill: none; stroke-dasharray: 2=
.96,1.28; stroke-dashoffset: 0; stroke: #b0b0b0; stroke-opacity: 0.5; strok=
e-width: 0.8"/>
+     </g>
+     <g id=3D"line2d_16">
+      <defs>
+       <path id=3D"m0bd8e88372" d=3D"M 0 0=20
+L -3.5 0=20
+" style=3D"stroke: #000000; stroke-width: 0.8"/>
+      </defs>
+      <g>
+       <use xlink:href=3D"#m0bd8e88372" x=3D"54.295938" y=3D"374.128276" s=
tyle=3D"stroke: #000000; stroke-width: 0.8"/>
+      </g>
+     </g>
+     <g id=3D"text_9">
+      <!-- 0 -->
+      <g transform=3D"translate(40.933438 377.927495) scale(0.1 -0.1)">
+       <use xlink:href=3D"#DejaVuSans-30"/>
+      </g>
+     </g>
+    </g>
+    <g id=3D"ytick_2">
+     <g id=3D"line2d_17">
+      <path d=3D"M 54.295938 329.841988=20
+L 705.335938 329.841988=20
+" clip-path=3D"url(#p5b9f229a39)" style=3D"fill: none; stroke-dasharray: 2=
.96,1.28; stroke-dashoffset: 0; stroke: #b0b0b0; stroke-opacity: 0.5; strok=
e-width: 0.8"/>
+     </g>
+     <g id=3D"line2d_18">
+      <g>
+       <use xlink:href=3D"#m0bd8e88372" x=3D"54.295938" y=3D"329.841988" s=
tyle=3D"stroke: #000000; stroke-width: 0.8"/>
+      </g>
+     </g>
+     <g id=3D"text_10">
+      <!-- 250 -->
+      <g transform=3D"translate(28.208438 333.641207) scale(0.1 -0.1)">
+       <defs>
+        <path id=3D"DejaVuSans-35" d=3D"M 691 4666=20
+L 3169 4666=20
+L 3169 4134=20
+L 1269 4134=20
+L 1269 2991=20
+Q 1406 3038 1543 3061=20
+Q 1681 3084 1819 3084=20
+Q 2600 3084 3056 2656=20
+Q 3513 2228 3513 1497=20
+Q 3513 744 3044 326=20
+Q 2575 -91 1722 -91=20
+Q 1428 -91 1123 -41=20
+Q 819 9 494 109=20
+L 494 744=20
+Q 775 591 1075 516=20
+Q 1375 441 1709 441=20
+Q 2250 441 2565 725=20
+Q 2881 1009 2881 1497=20
+Q 2881 1984 2565 2268=20
+Q 2250 2553 1709 2553=20
+Q 1456 2553 1204 2497=20
+Q 953 2441 691 2322=20
+L 691 4666=20
+z
+" transform=3D"scale(0.015625)"/>
+       </defs>
+       <use xlink:href=3D"#DejaVuSans-32"/>
+       <use xlink:href=3D"#DejaVuSans-35" transform=3D"translate(63.623047=
 0)"/>
+       <use xlink:href=3D"#DejaVuSans-30" transform=3D"translate(127.24609=
4 0)"/>
+      </g>
+     </g>
+    </g>
+    <g id=3D"ytick_3">
+     <g id=3D"line2d_19">
+      <path d=3D"M 54.295938 285.555699=20
+L 705.335938 285.555699=20
+" clip-path=3D"url(#p5b9f229a39)" style=3D"fill: none; stroke-dasharray: 2=
.96,1.28; stroke-dashoffset: 0; stroke: #b0b0b0; stroke-opacity: 0.5; strok=
e-width: 0.8"/>
+     </g>
+     <g id=3D"line2d_20">
+      <g>
+       <use xlink:href=3D"#m0bd8e88372" x=3D"54.295938" y=3D"285.555699" s=
tyle=3D"stroke: #000000; stroke-width: 0.8"/>
+      </g>
+     </g>
+     <g id=3D"text_11">
+      <!-- 500 -->
+      <g transform=3D"translate(28.208438 289.354918) scale(0.1 -0.1)">
+       <use xlink:href=3D"#DejaVuSans-35"/>
+       <use xlink:href=3D"#DejaVuSans-30" transform=3D"translate(63.623047=
 0)"/>
+       <use xlink:href=3D"#DejaVuSans-30" transform=3D"translate(127.24609=
4 0)"/>
+      </g>
+     </g>
+    </g>
+    <g id=3D"ytick_4">
+     <g id=3D"line2d_21">
+      <path d=3D"M 54.295938 241.269411=20
+L 705.335938 241.269411=20
+" clip-path=3D"url(#p5b9f229a39)" style=3D"fill: none; stroke-dasharray: 2=
.96,1.28; stroke-dashoffset: 0; stroke: #b0b0b0; stroke-opacity: 0.5; strok=
e-width: 0.8"/>
+     </g>
+     <g id=3D"line2d_22">
+      <g>
+       <use xlink:href=3D"#m0bd8e88372" x=3D"54.295938" y=3D"241.269411" s=
tyle=3D"stroke: #000000; stroke-width: 0.8"/>
+      </g>
+     </g>
+     <g id=3D"text_12">
+      <!-- 750 -->
+      <g transform=3D"translate(28.208438 245.06863) scale(0.1 -0.1)">
+       <defs>
+        <path id=3D"DejaVuSans-37" d=3D"M 525 4666=20
+L 3525 4666=20
+L 3525 4397=20
+L 1831 0=20
+L 1172 0=20
+L 2766 4134=20
+L 525 4134=20
+L 525 4666=20
+z
+" transform=3D"scale(0.015625)"/>
+       </defs>
+       <use xlink:href=3D"#DejaVuSans-37"/>
+       <use xlink:href=3D"#DejaVuSans-35" transform=3D"translate(63.623047=
 0)"/>
+       <use xlink:href=3D"#DejaVuSans-30" transform=3D"translate(127.24609=
4 0)"/>
+      </g>
+     </g>
+    </g>
+    <g id=3D"ytick_5">
+     <g id=3D"line2d_23">
+      <path d=3D"M 54.295938 196.983122=20
+L 705.335938 196.983122=20
+" clip-path=3D"url(#p5b9f229a39)" style=3D"fill: none; stroke-dasharray: 2=
.96,1.28; stroke-dashoffset: 0; stroke: #b0b0b0; stroke-opacity: 0.5; strok=
e-width: 0.8"/>
+     </g>
+     <g id=3D"line2d_24">
+      <g>
+       <use xlink:href=3D"#m0bd8e88372" x=3D"54.295938" y=3D"196.983122" s=
tyle=3D"stroke: #000000; stroke-width: 0.8"/>
+      </g>
+     </g>
+     <g id=3D"text_13">
+      <!-- 1000 -->
+      <g transform=3D"translate(21.845938 200.782341) scale(0.1 -0.1)">
+       <defs>
+        <path id=3D"DejaVuSans-31" d=3D"M 794 531=20
+L 1825 531=20
+L 1825 4091=20
+L 703 3866=20
+L 703 4441=20
+L 1819 4666=20
+L 2450 4666=20
+L 2450 531=20
+L 3481 531=20
+L 3481 0=20
+L 794 0=20
+L 794 531=20
+z
+" transform=3D"scale(0.015625)"/>
+       </defs>
+       <use xlink:href=3D"#DejaVuSans-31"/>
+       <use xlink:href=3D"#DejaVuSans-30" transform=3D"translate(63.623047=
 0)"/>
+       <use xlink:href=3D"#DejaVuSans-30" transform=3D"translate(127.24609=
4 0)"/>
+       <use xlink:href=3D"#DejaVuSans-30" transform=3D"translate(190.86914=
1 0)"/>
+      </g>
+     </g>
+    </g>
+    <g id=3D"ytick_6">
+     <g id=3D"line2d_25">
+      <path d=3D"M 54.295938 152.696834=20
+L 705.335938 152.696834=20
+" clip-path=3D"url(#p5b9f229a39)" style=3D"fill: none; stroke-dasharray: 2=
.96,1.28; stroke-dashoffset: 0; stroke: #b0b0b0; stroke-opacity: 0.5; strok=
e-width: 0.8"/>
+     </g>
+     <g id=3D"line2d_26">
+      <g>
+       <use xlink:href=3D"#m0bd8e88372" x=3D"54.295938" y=3D"152.696834" s=
tyle=3D"stroke: #000000; stroke-width: 0.8"/>
+      </g>
+     </g>
+     <g id=3D"text_14">
+      <!-- 1250 -->
+      <g transform=3D"translate(21.845938 156.496053) scale(0.1 -0.1)">
+       <use xlink:href=3D"#DejaVuSans-31"/>
+       <use xlink:href=3D"#DejaVuSans-32" transform=3D"translate(63.623047=
 0)"/>
+       <use xlink:href=3D"#DejaVuSans-35" transform=3D"translate(127.24609=
4 0)"/>
+       <use xlink:href=3D"#DejaVuSans-30" transform=3D"translate(190.86914=
1 0)"/>
+      </g>
+     </g>
+    </g>
+    <g id=3D"ytick_7">
+     <g id=3D"line2d_27">
+      <path d=3D"M 54.295938 108.410546=20
+L 705.335938 108.410546=20
+" clip-path=3D"url(#p5b9f229a39)" style=3D"fill: none; stroke-dasharray: 2=
.96,1.28; stroke-dashoffset: 0; stroke: #b0b0b0; stroke-opacity: 0.5; strok=
e-width: 0.8"/>
+     </g>
+     <g id=3D"line2d_28">
+      <g>
+       <use xlink:href=3D"#m0bd8e88372" x=3D"54.295938" y=3D"108.410546" s=
tyle=3D"stroke: #000000; stroke-width: 0.8"/>
+      </g>
+     </g>
+     <g id=3D"text_15">
+      <!-- 1500 -->
+      <g transform=3D"translate(21.845938 112.209764) scale(0.1 -0.1)">
+       <use xlink:href=3D"#DejaVuSans-31"/>
+       <use xlink:href=3D"#DejaVuSans-35" transform=3D"translate(63.623047=
 0)"/>
+       <use xlink:href=3D"#DejaVuSans-30" transform=3D"translate(127.24609=
4 0)"/>
+       <use xlink:href=3D"#DejaVuSans-30" transform=3D"translate(190.86914=
1 0)"/>
+      </g>
+     </g>
+    </g>
+    <g id=3D"ytick_8">
+     <g id=3D"line2d_29">
+      <path d=3D"M 54.295938 64.124257=20
+L 705.335938 64.124257=20
+" clip-path=3D"url(#p5b9f229a39)" style=3D"fill: none; stroke-dasharray: 2=
.96,1.28; stroke-dashoffset: 0; stroke: #b0b0b0; stroke-opacity: 0.5; strok=
e-width: 0.8"/>
+     </g>
+     <g id=3D"line2d_30">
+      <g>
+       <use xlink:href=3D"#m0bd8e88372" x=3D"54.295938" y=3D"64.124257" st=
yle=3D"stroke: #000000; stroke-width: 0.8"/>
+      </g>
+     </g>
+     <g id=3D"text_16">
+      <!-- 1750 -->
+      <g transform=3D"translate(21.845938 67.923476) scale(0.1 -0.1)">
+       <use xlink:href=3D"#DejaVuSans-31"/>
+       <use xlink:href=3D"#DejaVuSans-37" transform=3D"translate(63.623047=
 0)"/>
+       <use xlink:href=3D"#DejaVuSans-35" transform=3D"translate(127.24609=
4 0)"/>
+       <use xlink:href=3D"#DejaVuSans-30" transform=3D"translate(190.86914=
1 0)"/>
+      </g>
+     </g>
+    </g>
+    <g id=3D"text_17">
+     <!-- Number of Issues -->
+     <g transform=3D"translate(15.558281 249.96281) rotate(-90) scale(0.11=
 -0.11)">
+      <defs>
+       <path id=3D"DejaVuSans-6d" d=3D"M 3328 2828=20
+Q 3544 3216 3844 3400=20
+Q 4144 3584 4550 3584=20
+Q 5097 3584 5394 3201=20
+Q 5691 2819 5691 2113=20
+L 5691 0=20
+L 5113 0=20
+L 5113 2094=20
+Q 5113 2597 4934 2840=20
+Q 4756 3084 4391 3084=20
+Q 3944 3084 3684 2787=20
+Q 3425 2491 3425 1978=20
+L 3425 0=20
+L 2847 0=20
+L 2847 2094=20
+Q 2847 2600 2669 2842=20
+Q 2491 3084 2119 3084=20
+Q 1678 3084 1418 2786=20
+Q 1159 2488 1159 1978=20
+L 1159 0=20
+L 581 0=20
+L 581 3500=20
+L 1159 3500=20
+L 1159 2956=20
+Q 1356 3278 1631 3431=20
+Q 1906 3584 2284 3584=20
+Q 2666 3584 2933 3390=20
+Q 3200 3197 3328 2828=20
+z
+" transform=3D"scale(0.015625)"/>
+       <path id=3D"DejaVuSans-62" d=3D"M 3116 1747=20
+Q 3116 2381 2855 2742=20
+Q 2594 3103 2138 3103=20
+Q 1681 3103 1420 2742=20
+Q 1159 2381 1159 1747=20
+Q 1159 1113 1420 752=20
+Q 1681 391 2138 391=20
+Q 2594 391 2855 752=20
+Q 3116 1113 3116 1747=20
+z
+M 1159 2969=20
+Q 1341 3281 1617 3432=20
+Q 1894 3584 2278 3584=20
+Q 2916 3584 3314 3078=20
+Q 3713 2572 3713 1747=20
+Q 3713 922 3314 415=20
+Q 2916 -91 2278 -91=20
+Q 1894 -91 1617 61=20
+Q 1341 213 1159 525=20
+L 1159 0=20
+L 581 0=20
+L 581 4863=20
+L 1159 4863=20
+L 1159 2969=20
+z
+" transform=3D"scale(0.015625)"/>
+       <path id=3D"DejaVuSans-20" transform=3D"scale(0.015625)"/>
+       <path id=3D"DejaVuSans-66" d=3D"M 2375 4863=20
+L 2375 4384=20
+L 1825 4384=20
+Q 1516 4384 1395 4259=20
+Q 1275 4134 1275 3809=20
+L 1275 3500=20
+L 2222 3500=20
+L 2222 3053=20
+L 1275 3053=20
+L 1275 0=20
+L 697 0=20
+L 697 3053=20
+L 147 3053=20
+L 147 3500=20
+L 697 3500=20
+L 697 3744=20
+Q 697 4328 969 4595=20
+Q 1241 4863 1831 4863=20
+L 2375 4863=20
+z
+" transform=3D"scale(0.015625)"/>
+       <path id=3D"DejaVuSans-49" d=3D"M 628 4666=20
+L 1259 4666=20
+L 1259 0=20
+L 628 0=20
+L 628 4666=20
+z
+" transform=3D"scale(0.015625)"/>
+       <path id=3D"DejaVuSans-73" d=3D"M 2834 3397=20
+L 2834 2853=20
+Q 2591 2978 2328 3040=20
+Q 2066 3103 1784 3103=20
+Q 1356 3103 1142 2972=20
+Q 928 2841 928 2578=20
+Q 928 2378 1081 2264=20
+Q 1234 2150 1697 2047=20
+L 1894 2003=20
+Q 2506 1872 2764 1633=20
+Q 3022 1394 3022 966=20
+Q 3022 478 2636 193=20
+Q 2250 -91 1575 -91=20
+Q 1294 -91 989 -36=20
+Q 684 19 347 128=20
+L 347 722=20
+Q 666 556 975 473=20
+Q 1284 391 1588 391=20
+Q 1994 391 2212 530=20
+Q 2431 669 2431 922=20
+Q 2431 1156 2273 1281=20
+Q 2116 1406 1581 1522=20
+L 1381 1569=20
+Q 847 1681 609 1914=20
+Q 372 2147 372 2553=20
+Q 372 3047 722 3315=20
+Q 1072 3584 1716 3584=20
+Q 2034 3584 2315 3537=20
+Q 2597 3491 2834 3397=20
+z
+" transform=3D"scale(0.015625)"/>
+      </defs>
+      <use xlink:href=3D"#DejaVuSans-4e"/>
+      <use xlink:href=3D"#DejaVuSans-75" transform=3D"translate(74.804688 =
0)"/>
+      <use xlink:href=3D"#DejaVuSans-6d" transform=3D"translate(138.183594=
 0)"/>
+      <use xlink:href=3D"#DejaVuSans-62" transform=3D"translate(235.595703=
 0)"/>
+      <use xlink:href=3D"#DejaVuSans-65" transform=3D"translate(299.072266=
 0)"/>
+      <use xlink:href=3D"#DejaVuSans-72" transform=3D"translate(360.595703=
 0)"/>
+      <use xlink:href=3D"#DejaVuSans-20" transform=3D"translate(401.708984=
 0)"/>
+      <use xlink:href=3D"#DejaVuSans-6f" transform=3D"translate(433.496094=
 0)"/>
+      <use xlink:href=3D"#DejaVuSans-66" transform=3D"translate(494.677734=
 0)"/>
+      <use xlink:href=3D"#DejaVuSans-20" transform=3D"translate(529.882812=
 0)"/>
+      <use xlink:href=3D"#DejaVuSans-49" transform=3D"translate(561.669922=
 0)"/>
+      <use xlink:href=3D"#DejaVuSans-73" transform=3D"translate(591.162109=
 0)"/>
+      <use xlink:href=3D"#DejaVuSans-73" transform=3D"translate(643.261719=
 0)"/>
+      <use xlink:href=3D"#DejaVuSans-75" transform=3D"translate(695.361328=
 0)"/>
+      <use xlink:href=3D"#DejaVuSans-65" transform=3D"translate(758.740234=
 0)"/>
+      <use xlink:href=3D"#DejaVuSans-73" transform=3D"translate(820.263672=
 0)"/>
+     </g>
+    </g>
+   </g>
+   <g id=3D"patch_3">
+    <path d=3D"M 54.295938 374.128276=20
+L 54.295938 29.837812=20
+" style=3D"fill: none; stroke: #000000; stroke-width: 0.8; stroke-linejoin=
: miter; stroke-linecap: square"/>
+   </g>
+   <g id=3D"patch_4">
+    <path d=3D"M 705.335938 374.128276=20
+L 705.335938 29.837812=20
+" style=3D"fill: none; stroke: #000000; stroke-width: 0.8; stroke-linejoin=
: miter; stroke-linecap: square"/>
+   </g>
+   <g id=3D"patch_5">
+    <path d=3D"M 54.295937 374.128276=20
+L 705.335938 374.128276=20
+" style=3D"fill: none; stroke: #000000; stroke-width: 0.8; stroke-linejoin=
: miter; stroke-linecap: square"/>
+   </g>
+   <g id=3D"patch_6">
+    <path d=3D"M 54.295937 29.837812=20
+L 705.335938 29.837812=20
+" style=3D"fill: none; stroke: #000000; stroke-width: 0.8; stroke-linejoin=
: miter; stroke-linecap: square"/>
+   </g>
+   <g id=3D"text_18">
+    <!-- Cumulative GitLab Issues (Closed vs Open) -->
+    <g transform=3D"translate(210.443281 17.837812) scale(0.14 -0.14)">
+     <defs>
+      <path id=3D"DejaVuSans-Bold-43" d=3D"M 4288 256=20
+Q 3956 84 3597 -3=20
+Q 3238 -91 2847 -91=20
+Q 1681 -91 1000 561=20
+Q 319 1213 319 2328=20
+Q 319 3447 1000 4098=20
+Q 1681 4750 2847 4750=20
+Q 3238 4750 3597 4662=20
+Q 3956 4575 4288 4403=20
+L 4288 3438=20
+Q 3953 3666 3628 3772=20
+Q 3303 3878 2944 3878=20
+Q 2300 3878 1931 3465=20
+Q 1563 3053 1563 2328=20
+Q 1563 1606 1931 1193=20
+Q 2300 781 2944 781=20
+Q 3303 781 3628 887=20
+Q 3953 994 4288 1222=20
+L 4288 256=20
+z
+" transform=3D"scale(0.015625)"/>
+      <path id=3D"DejaVuSans-Bold-75" d=3D"M 500 1363=20
+L 500 3500=20
+L 1625 3500=20
+L 1625 3150=20
+Q 1625 2866 1622 2436=20
+Q 1619 2006 1619 1863=20
+Q 1619 1441 1641 1255=20
+Q 1663 1069 1716 984=20
+Q 1784 875 1895 815=20
+Q 2006 756 2150 756=20
+Q 2500 756 2700 1025=20
+Q 2900 1294 2900 1772=20
+L 2900 3500=20
+L 4019 3500=20
+L 4019 0=20
+L 2900 0=20
+L 2900 506=20
+Q 2647 200 2364 54=20
+Q 2081 -91 1741 -91=20
+Q 1134 -91 817 281=20
+Q 500 653 500 1363=20
+z
+" transform=3D"scale(0.015625)"/>
+      <path id=3D"DejaVuSans-Bold-6d" d=3D"M 3781 2919=20
+Q 3994 3244 4286 3414=20
+Q 4578 3584 4928 3584=20
+Q 5531 3584 5847 3212=20
+Q 6163 2841 6163 2131=20
+L 6163 0=20
+L 5038 0=20
+L 5038 1825=20
+Q 5041 1866 5042 1909=20
+Q 5044 1953 5044 2034=20
+Q 5044 2406 4934 2573=20
+Q 4825 2741 4581 2741=20
+Q 4263 2741 4089 2478=20
+Q 3916 2216 3909 1719=20
+L 3909 0=20
+L 2784 0=20
+L 2784 1825=20
+Q 2784 2406 2684 2573=20
+Q 2584 2741 2328 2741=20
+Q 2006 2741 1831 2477=20
+Q 1656 2213 1656 1722=20
+L 1656 0=20
+L 531 0=20
+L 531 3500=20
+L 1656 3500=20
+L 1656 2988=20
+Q 1863 3284 2130 3434=20
+Q 2397 3584 2719 3584=20
+Q 3081 3584 3359 3409=20
+Q 3638 3234 3781 2919=20
+z
+" transform=3D"scale(0.015625)"/>
+      <path id=3D"DejaVuSans-Bold-6c" d=3D"M 538 4863=20
+L 1656 4863=20
+L 1656 0=20
+L 538 0=20
+L 538 4863=20
+z
+" transform=3D"scale(0.015625)"/>
+      <path id=3D"DejaVuSans-Bold-61" d=3D"M 2106 1575=20
+Q 1756 1575 1579 1456=20
+Q 1403 1338 1403 1106=20
+Q 1403 894 1545 773=20
+Q 1688 653 1941 653=20
+Q 2256 653 2472 879=20
+Q 2688 1106 2688 1447=20
+L 2688 1575=20
+L 2106 1575=20
+z
+M 3816 1997=20
+L 3816 0=20
+L 2688 0=20
+L 2688 519=20
+Q 2463 200 2181 54=20
+Q 1900 -91 1497 -91=20
+Q 953 -91 614 226=20
+Q 275 544 275 1050=20
+Q 275 1666 698 1953=20
+Q 1122 2241 2028 2241=20
+L 2688 2241=20
+L 2688 2328=20
+Q 2688 2594 2478 2717=20
+Q 2269 2841 1825 2841=20
+Q 1466 2841 1156 2769=20
+Q 847 2697 581 2553=20
+L 581 3406=20
+Q 941 3494 1303 3539=20
+Q 1666 3584 2028 3584=20
+Q 2975 3584 3395 3211=20
+Q 3816 2838 3816 1997=20
+z
+" transform=3D"scale(0.015625)"/>
+      <path id=3D"DejaVuSans-Bold-74" d=3D"M 1759 4494=20
+L 1759 3500=20
+L 2913 3500=20
+L 2913 2700=20
+L 1759 2700=20
+L 1759 1216=20
+Q 1759 972 1856 886=20
+Q 1953 800 2241 800=20
+L 2816 800=20
+L 2816 0=20
+L 1856 0=20
+Q 1194 0 917 276=20
+Q 641 553 641 1216=20
+L 641 2700=20
+L 84 2700=20
+L 84 3500=20
+L 641 3500=20
+L 641 4494=20
+L 1759 4494=20
+z
+" transform=3D"scale(0.015625)"/>
+      <path id=3D"DejaVuSans-Bold-69" d=3D"M 538 3500=20
+L 1656 3500=20
+L 1656 0=20
+L 538 0=20
+L 538 3500=20
+z
+M 538 4863=20
+L 1656 4863=20
+L 1656 3950=20
+L 538 3950=20
+L 538 4863=20
+z
+" transform=3D"scale(0.015625)"/>
+      <path id=3D"DejaVuSans-Bold-76" d=3D"M 97 3500=20
+L 1216 3500=20
+L 2088 1081=20
+L 2956 3500=20
+L 4078 3500=20
+L 2700 0=20
+L 1472 0=20
+L 97 3500=20
+z
+" transform=3D"scale(0.015625)"/>
+      <path id=3D"DejaVuSans-Bold-65" d=3D"M 4031 1759=20
+L 4031 1441=20
+L 1416 1441=20
+Q 1456 1047 1700 850=20
+Q 1944 653 2381 653=20
+Q 2734 653 3104 758=20
+Q 3475 863 3866 1075=20
+L 3866 213=20
+Q 3469 63 3072 -14=20
+Q 2675 -91 2278 -91=20
+Q 1328 -91 801 392=20
+Q 275 875 275 1747=20
+Q 275 2603 792 3093=20
+Q 1309 3584 2216 3584=20
+Q 3041 3584 3536 3087=20
+Q 4031 2591 4031 1759=20
+z
+M 2881 2131=20
+Q 2881 2450 2695 2645=20
+Q 2509 2841 2209 2841=20
+Q 1884 2841 1681 2658=20
+Q 1478 2475 1428 2131=20
+L 2881 2131=20
+z
+" transform=3D"scale(0.015625)"/>
+      <path id=3D"DejaVuSans-Bold-20" transform=3D"scale(0.015625)"/>
+      <path id=3D"DejaVuSans-Bold-47" d=3D"M 4781 347=20
+Q 4331 128 3847 18=20
+Q 3363 -91 2847 -91=20
+Q 1681 -91 1000 561=20
+Q 319 1213 319 2328=20
+Q 319 3456 1012 4103=20
+Q 1706 4750 2913 4750=20
+Q 3378 4750 3804 4662=20
+Q 4231 4575 4609 4403=20
+L 4609 3438=20
+Q 4219 3659 3833 3768=20
+Q 3447 3878 3059 3878=20
+Q 2341 3878 1952 3476=20
+Q 1563 3075 1563 2328=20
+Q 1563 1588 1938 1184=20
+Q 2313 781 3003 781=20
+Q 3191 781 3352 804=20
+Q 3513 828 3641 878=20
+L 3641 1784=20
+L 2906 1784=20
+L 2906 2591=20
+L 4781 2591=20
+L 4781 347=20
+z
+" transform=3D"scale(0.015625)"/>
+      <path id=3D"DejaVuSans-Bold-4c" d=3D"M 588 4666=20
+L 1791 4666=20
+L 1791 909=20
+L 3903 909=20
+L 3903 0=20
+L 588 0=20
+L 588 4666=20
+z
+" transform=3D"scale(0.015625)"/>
+      <path id=3D"DejaVuSans-Bold-62" d=3D"M 2400 722=20
+Q 2759 722 2948 984=20
+Q 3138 1247 3138 1747=20
+Q 3138 2247 2948 2509=20
+Q 2759 2772 2400 2772=20
+Q 2041 2772 1848 2508=20
+Q 1656 2244 1656 1747=20
+Q 1656 1250 1848 986=20
+Q 2041 722 2400 722=20
+z
+M 1656 2988=20
+Q 1888 3294 2169 3439=20
+Q 2450 3584 2816 3584=20
+Q 3463 3584 3878 3070=20
+Q 4294 2556 4294 1747=20
+Q 4294 938 3878 423=20
+Q 3463 -91 2816 -91=20
+Q 2450 -91 2169 54=20
+Q 1888 200 1656 506=20
+L 1656 0=20
+L 538 0=20
+L 538 4863=20
+L 1656 4863=20
+L 1656 2988=20
+z
+" transform=3D"scale(0.015625)"/>
+      <path id=3D"DejaVuSans-Bold-49" d=3D"M 588 4666=20
+L 1791 4666=20
+L 1791 0=20
+L 588 0=20
+L 588 4666=20
+z
+" transform=3D"scale(0.015625)"/>
+      <path id=3D"DejaVuSans-Bold-73" d=3D"M 3272 3391=20
+L 3272 2541=20
+Q 2913 2691 2578 2766=20
+Q 2244 2841 1947 2841=20
+Q 1628 2841 1473 2761=20
+Q 1319 2681 1319 2516=20
+Q 1319 2381 1436 2309=20
+Q 1553 2238 1856 2203=20
+L 2053 2175=20
+Q 2913 2066 3209 1816=20
+Q 3506 1566 3506 1031=20
+Q 3506 472 3093 190=20
+Q 2681 -91 1863 -91=20
+Q 1516 -91 1145 -36=20
+Q 775 19 384 128=20
+L 384 978=20
+Q 719 816 1070 734=20
+Q 1422 653 1784 653=20
+Q 2113 653 2278 743=20
+Q 2444 834 2444 1013=20
+Q 2444 1163 2330 1236=20
+Q 2216 1309 1875 1350=20
+L 1678 1375=20
+Q 931 1469 631 1722=20
+Q 331 1975 331 2491=20
+Q 331 3047 712 3315=20
+Q 1094 3584 1881 3584=20
+Q 2191 3584 2531 3537=20
+Q 2872 3491 3272 3391=20
+z
+" transform=3D"scale(0.015625)"/>
+      <path id=3D"DejaVuSans-Bold-28" d=3D"M 2413 -844=20
+L 1484 -844=20
+Q 1006 -72 778 623=20
+Q 550 1319 550 2003=20
+Q 550 2688 779 3389=20
+Q 1009 4091 1484 4856=20
+L 2413 4856=20
+Q 2013 4116 1813 3408=20
+Q 1613 2700 1613 2009=20
+Q 1613 1319 1811 609=20
+Q 2009 -100 2413 -844=20
+z
+" transform=3D"scale(0.015625)"/>
+      <path id=3D"DejaVuSans-Bold-6f" d=3D"M 2203 2784=20
+Q 1831 2784 1636 2517=20
+Q 1441 2250 1441 1747=20
+Q 1441 1244 1636 976=20
+Q 1831 709 2203 709=20
+Q 2569 709 2762 976=20
+Q 2956 1244 2956 1747=20
+Q 2956 2250 2762 2517=20
+Q 2569 2784 2203 2784=20
+z
+M 2203 3584=20
+Q 3106 3584 3614 3096=20
+Q 4122 2609 4122 1747=20
+Q 4122 884 3614 396=20
+Q 3106 -91 2203 -91=20
+Q 1297 -91 786 396=20
+Q 275 884 275 1747=20
+Q 275 2609 786 3096=20
+Q 1297 3584 2203 3584=20
+z
+" transform=3D"scale(0.015625)"/>
+      <path id=3D"DejaVuSans-Bold-64" d=3D"M 2919 2988=20
+L 2919 4863=20
+L 4044 4863=20
+L 4044 0=20
+L 2919 0=20
+L 2919 506=20
+Q 2688 197 2409 53=20
+Q 2131 -91 1766 -91=20
+Q 1119 -91 703 423=20
+Q 288 938 288 1747=20
+Q 288 2556 703 3070=20
+Q 1119 3584 1766 3584=20
+Q 2128 3584 2408 3439=20
+Q 2688 3294 2919 2988=20
+z
+M 2181 722=20
+Q 2541 722 2730 984=20
+Q 2919 1247 2919 1747=20
+Q 2919 2247 2730 2509=20
+Q 2541 2772 2181 2772=20
+Q 1825 2772 1636 2509=20
+Q 1447 2247 1447 1747=20
+Q 1447 1247 1636 984=20
+Q 1825 722 2181 722=20
+z
+" transform=3D"scale(0.015625)"/>
+      <path id=3D"DejaVuSans-Bold-4f" d=3D"M 2719 3878=20
+Q 2169 3878 1866 3472=20
+Q 1563 3066 1563 2328=20
+Q 1563 1594 1866 1187=20
+Q 2169 781 2719 781=20
+Q 3272 781 3575 1187=20
+Q 3878 1594 3878 2328=20
+Q 3878 3066 3575 3472=20
+Q 3272 3878 2719 3878=20
+z
+M 2719 4750=20
+Q 3844 4750 4481 4106=20
+Q 5119 3463 5119 2328=20
+Q 5119 1197 4481 553=20
+Q 3844 -91 2719 -91=20
+Q 1597 -91 958 553=20
+Q 319 1197 319 2328=20
+Q 319 3463 958 4106=20
+Q 1597 4750 2719 4750=20
+z
+" transform=3D"scale(0.015625)"/>
+      <path id=3D"DejaVuSans-Bold-70" d=3D"M 1656 506=20
+L 1656 -1331=20
+L 538 -1331=20
+L 538 3500=20
+L 1656 3500=20
+L 1656 2988=20
+Q 1888 3294 2169 3439=20
+Q 2450 3584 2816 3584=20
+Q 3463 3584 3878 3070=20
+Q 4294 2556 4294 1747=20
+Q 4294 938 3878 423=20
+Q 3463 -91 2816 -91=20
+Q 2450 -91 2169 54=20
+Q 1888 200 1656 506=20
+z
+M 2400 2772=20
+Q 2041 2772 1848 2508=20
+Q 1656 2244 1656 1747=20
+Q 1656 1250 1848 986=20
+Q 2041 722 2400 722=20
+Q 2759 722 2948 984=20
+Q 3138 1247 3138 1747=20
+Q 3138 2247 2948 2509=20
+Q 2759 2772 2400 2772=20
+z
+" transform=3D"scale(0.015625)"/>
+      <path id=3D"DejaVuSans-Bold-6e" d=3D"M 4056 2131=20
+L 4056 0=20
+L 2931 0=20
+L 2931 347=20
+L 2931 1631=20
+Q 2931 2084 2911 2256=20
+Q 2891 2428 2841 2509=20
+Q 2775 2619 2662 2680=20
+Q 2550 2741 2406 2741=20
+Q 2056 2741 1856 2470=20
+Q 1656 2200 1656 1722=20
+L 1656 0=20
+L 538 0=20
+L 538 3500=20
+L 1656 3500=20
+L 1656 2988=20
+Q 1909 3294 2193 3439=20
+Q 2478 3584 2822 3584=20
+Q 3428 3584 3742 3212=20
+Q 4056 2841 4056 2131=20
+z
+" transform=3D"scale(0.015625)"/>
+      <path id=3D"DejaVuSans-Bold-29" d=3D"M 513 -844=20
+Q 913 -100 1113 609=20
+Q 1313 1319 1313 2009=20
+Q 1313 2700 1113 3408=20
+Q 913 4116 513 4856=20
+L 1441 4856=20
+Q 1916 4091 2145 3389=20
+Q 2375 2688 2375 2003=20
+Q 2375 1319 2147 623=20
+Q 1919 -72 1441 -844=20
+L 513 -844=20
+z
+" transform=3D"scale(0.015625)"/>
+     </defs>
+     <use xlink:href=3D"#DejaVuSans-Bold-43"/>
+     <use xlink:href=3D"#DejaVuSans-Bold-75" transform=3D"translate(73.388=
672 0)"/>
+     <use xlink:href=3D"#DejaVuSans-Bold-6d" transform=3D"translate(144.58=
0078 0)"/>
+     <use xlink:href=3D"#DejaVuSans-Bold-75" transform=3D"translate(248.77=
9297 0)"/>
+     <use xlink:href=3D"#DejaVuSans-Bold-6c" transform=3D"translate(319.97=
0703 0)"/>
+     <use xlink:href=3D"#DejaVuSans-Bold-61" transform=3D"translate(354.24=
8047 0)"/>
+     <use xlink:href=3D"#DejaVuSans-Bold-74" transform=3D"translate(421.72=
8516 0)"/>
+     <use xlink:href=3D"#DejaVuSans-Bold-69" transform=3D"translate(469.53=
125 0)"/>
+     <use xlink:href=3D"#DejaVuSans-Bold-76" transform=3D"translate(503.80=
8594 0)"/>
+     <use xlink:href=3D"#DejaVuSans-Bold-65" transform=3D"translate(568.99=
4141 0)"/>
+     <use xlink:href=3D"#DejaVuSans-Bold-20" transform=3D"translate(636.81=
6406 0)"/>
+     <use xlink:href=3D"#DejaVuSans-Bold-47" transform=3D"translate(671.63=
0859 0)"/>
+     <use xlink:href=3D"#DejaVuSans-Bold-69" transform=3D"translate(753.71=
0938 0)"/>
+     <use xlink:href=3D"#DejaVuSans-Bold-74" transform=3D"translate(787.98=
8281 0)"/>
+     <use xlink:href=3D"#DejaVuSans-Bold-4c" transform=3D"translate(835.79=
1016 0)"/>
+     <use xlink:href=3D"#DejaVuSans-Bold-61" transform=3D"translate(899.51=
1719 0)"/>
+     <use xlink:href=3D"#DejaVuSans-Bold-62" transform=3D"translate(966.99=
2188 0)"/>
+     <use xlink:href=3D"#DejaVuSans-Bold-20" transform=3D"translate(1038.5=
74219 0)"/>
+     <use xlink:href=3D"#DejaVuSans-Bold-49" transform=3D"translate(1073.3=
88672 0)"/>
+     <use xlink:href=3D"#DejaVuSans-Bold-73" transform=3D"translate(1110.5=
95703 0)"/>
+     <use xlink:href=3D"#DejaVuSans-Bold-73" transform=3D"translate(1170.1=
17188 0)"/>
+     <use xlink:href=3D"#DejaVuSans-Bold-75" transform=3D"translate(1229.6=
38672 0)"/>
+     <use xlink:href=3D"#DejaVuSans-Bold-65" transform=3D"translate(1300.8=
30078 0)"/>
+     <use xlink:href=3D"#DejaVuSans-Bold-73" transform=3D"translate(1368.6=
52344 0)"/>
+     <use xlink:href=3D"#DejaVuSans-Bold-20" transform=3D"translate(1428.1=
73828 0)"/>
+     <use xlink:href=3D"#DejaVuSans-Bold-28" transform=3D"translate(1462.9=
88281 0)"/>
+     <use xlink:href=3D"#DejaVuSans-Bold-43" transform=3D"translate(1508.6=
91406 0)"/>
+     <use xlink:href=3D"#DejaVuSans-Bold-6c" transform=3D"translate(1582.0=
80078 0)"/>
+     <use xlink:href=3D"#DejaVuSans-Bold-6f" transform=3D"translate(1616.3=
57422 0)"/>
+     <use xlink:href=3D"#DejaVuSans-Bold-73" transform=3D"translate(1685.0=
58594 0)"/>
+     <use xlink:href=3D"#DejaVuSans-Bold-65" transform=3D"translate(1744.5=
80078 0)"/>
+     <use xlink:href=3D"#DejaVuSans-Bold-64" transform=3D"translate(1812.4=
02344 0)"/>
+     <use xlink:href=3D"#DejaVuSans-Bold-20" transform=3D"translate(1883.9=
84375 0)"/>
+     <use xlink:href=3D"#DejaVuSans-Bold-76" transform=3D"translate(1918.7=
98828 0)"/>
+     <use xlink:href=3D"#DejaVuSans-Bold-73" transform=3D"translate(1983.9=
84375 0)"/>
+     <use xlink:href=3D"#DejaVuSans-Bold-20" transform=3D"translate(2043.5=
05859 0)"/>
+     <use xlink:href=3D"#DejaVuSans-Bold-4f" transform=3D"translate(2078.3=
20312 0)"/>
+     <use xlink:href=3D"#DejaVuSans-Bold-70" transform=3D"translate(2163.3=
30078 0)"/>
+     <use xlink:href=3D"#DejaVuSans-Bold-65" transform=3D"translate(2234.9=
12109 0)"/>
+     <use xlink:href=3D"#DejaVuSans-Bold-6e" transform=3D"translate(2302.7=
34375 0)"/>
+     <use xlink:href=3D"#DejaVuSans-Bold-29" transform=3D"translate(2373.9=
25781 0)"/>
+    </g>
+   </g>
+   <g id=3D"legend_1">
+    <g id=3D"patch_7">
+     <path d=3D"M 61.295938 67.194062=20
+L 204.758438 67.194062=20
+Q 206.758438 67.194062 206.758438 65.194062=20
+L 206.758438 36.837812=20
+Q 206.758438 34.837812 204.758438 34.837812=20
+L 61.295938 34.837812=20
+Q 59.295938 34.837812 59.295938 36.837812=20
+L 59.295938 65.194062=20
+Q 59.295938 67.194062 61.295938 67.194062=20
+z
+" style=3D"fill: #ffffff; opacity: 0.8; stroke: #cccccc; stroke-linejoin: =
miter"/>
+    </g>
+    <g id=3D"patch_8">
+     <path d=3D"M 63.295938 46.43625=20
+L 83.295938 46.43625=20
+L 83.295938 39.43625=20
+L 63.295938 39.43625=20
+z
+" style=3D"fill: #2ca02c; fill-opacity: 0.75"/>
+    </g>
+    <g id=3D"text_19">
+     <!-- Closed Issues -->
+     <g transform=3D"translate(91.295938 46.43625) scale(0.1 -0.1)">
+      <defs>
+       <path id=3D"DejaVuSans-43" d=3D"M 4122 4306=20
+L 4122 3641=20
+Q 3803 3938 3442 4084=20
+Q 3081 4231 2675 4231=20
+Q 1875 4231 1450 3742=20
+Q 1025 3253 1025 2328=20
+Q 1025 1406 1450 917=20
+Q 1875 428 2675 428=20
+Q 3081 428 3442 575=20
+Q 3803 722 4122 1019=20
+L 4122 359=20
+Q 3791 134 3420 21=20
+Q 3050 -91 2638 -91=20
+Q 1578 -91 968 557=20
+Q 359 1206 359 2328=20
+Q 359 3453 968 4101=20
+Q 1578 4750 2638 4750=20
+Q 3056 4750 3426 4639=20
+Q 3797 4528 4122 4306=20
+z
+" transform=3D"scale(0.015625)"/>
+       <path id=3D"DejaVuSans-64" d=3D"M 2906 2969=20
+L 2906 4863=20
+L 3481 4863=20
+L 3481 0=20
+L 2906 0=20
+L 2906 525=20
+Q 2725 213 2448 61=20
+Q 2172 -91 1784 -91=20
+Q 1150 -91 751 415=20
+Q 353 922 353 1747=20
+Q 353 2572 751 3078=20
+Q 1150 3584 1784 3584=20
+Q 2172 3584 2448 3432=20
+Q 2725 3281 2906 2969=20
+z
+M 947 1747=20
+Q 947 1113 1208 752=20
+Q 1469 391 1925 391=20
+Q 2381 391 2643 752=20
+Q 2906 1113 2906 1747=20
+Q 2906 2381 2643 2742=20
+Q 2381 3103 1925 3103=20
+Q 1469 3103 1208 2742=20
+Q 947 2381 947 1747=20
+z
+" transform=3D"scale(0.015625)"/>
+      </defs>
+      <use xlink:href=3D"#DejaVuSans-43"/>
+      <use xlink:href=3D"#DejaVuSans-6c" transform=3D"translate(69.824219 =
0)"/>
+      <use xlink:href=3D"#DejaVuSans-6f" transform=3D"translate(97.607422 =
0)"/>
+      <use xlink:href=3D"#DejaVuSans-73" transform=3D"translate(158.789062=
 0)"/>
+      <use xlink:href=3D"#DejaVuSans-65" transform=3D"translate(210.888672=
 0)"/>
+      <use xlink:href=3D"#DejaVuSans-64" transform=3D"translate(272.412109=
 0)"/>
+      <use xlink:href=3D"#DejaVuSans-20" transform=3D"translate(335.888672=
 0)"/>
+      <use xlink:href=3D"#DejaVuSans-49" transform=3D"translate(367.675781=
 0)"/>
+      <use xlink:href=3D"#DejaVuSans-73" transform=3D"translate(397.167969=
 0)"/>
+      <use xlink:href=3D"#DejaVuSans-73" transform=3D"translate(449.267578=
 0)"/>
+      <use xlink:href=3D"#DejaVuSans-75" transform=3D"translate(501.367188=
 0)"/>
+      <use xlink:href=3D"#DejaVuSans-65" transform=3D"translate(564.746094=
 0)"/>
+      <use xlink:href=3D"#DejaVuSans-73" transform=3D"translate(626.269531=
 0)"/>
+     </g>
+    </g>
+    <g id=3D"patch_9">
+     <path d=3D"M 63.295938 61.114375=20
+L 83.295938 61.114375=20
+L 83.295938 54.114375=20
+L 63.295938 54.114375=20
+z
+" style=3D"fill: #d62728; fill-opacity: 0.75"/>
+    </g>
+    <g id=3D"text_20">
+     <!-- Open Issues (Backlog) -->
+     <g transform=3D"translate(91.295938 61.114375) scale(0.1 -0.1)">
+      <defs>
+       <path id=3D"DejaVuSans-4f" d=3D"M 2522 4238=20
+Q 1834 4238 1429 3725=20
+Q 1025 3213 1025 2328=20
+Q 1025 1447 1429 934=20
+Q 1834 422 2522 422=20
+Q 3209 422 3611 934=20
+Q 4013 1447 4013 2328=20
+Q 4013 3213 3611 3725=20
+Q 3209 4238 2522 4238=20
+z
+M 2522 4750=20
+Q 3503 4750 4090 4092=20
+Q 4678 3434 4678 2328=20
+Q 4678 1225 4090 567=20
+Q 3503 -91 2522 -91=20
+Q 1538 -91 948 565=20
+Q 359 1222 359 2328=20
+Q 359 3434 948 4092=20
+Q 1538 4750 2522 4750=20
+z
+" transform=3D"scale(0.015625)"/>
+       <path id=3D"DejaVuSans-6e" d=3D"M 3513 2113=20
+L 3513 0=20
+L 2938 0=20
+L 2938 2094=20
+Q 2938 2591 2744 2837=20
+Q 2550 3084 2163 3084=20
+Q 1697 3084 1428 2787=20
+Q 1159 2491 1159 1978=20
+L 1159 0=20
+L 581 0=20
+L 581 3500=20
+L 1159 3500=20
+L 1159 2956=20
+Q 1366 3272 1645 3428=20
+Q 1925 3584 2291 3584=20
+Q 2894 3584 3203 3211=20
+Q 3513 2838 3513 2113=20
+z
+" transform=3D"scale(0.015625)"/>
+       <path id=3D"DejaVuSans-28" d=3D"M 1984 4856=20
+Q 1566 4138 1362 3434=20
+Q 1159 2731 1159 2009=20
+Q 1159 1288 1364 580=20
+Q 1569 -128 1984 -844=20
+L 1484 -844=20
+Q 1016 -109 783 600=20
+Q 550 1309 550 2009=20
+Q 550 2706 781 3412=20
+Q 1013 4119 1484 4856=20
+L 1984 4856=20
+z
+" transform=3D"scale(0.015625)"/>
+       <path id=3D"DejaVuSans-42" d=3D"M 1259 2228=20
+L 1259 519=20
+L 2272 519=20
+Q 2781 519 3026 730=20
+Q 3272 941 3272 1375=20
+Q 3272 1813 3026 2020=20
+Q 2781 2228 2272 2228=20
+L 1259 2228=20
+z
+M 1259 4147=20
+L 1259 2741=20
+L 2194 2741=20
+Q 2656 2741 2882 2914=20
+Q 3109 3088 3109 3444=20
+Q 3109 3797 2882 3972=20
+Q 2656 4147 2194 4147=20
+L 1259 4147=20
+z
+M 628 4666=20
+L 2241 4666=20
+Q 2963 4666 3353 4366=20
+Q 3744 4066 3744 3513=20
+Q 3744 3084 3544 2831=20
+Q 3344 2578 2956 2516=20
+Q 3422 2416 3680 2098=20
+Q 3938 1781 3938 1306=20
+Q 3938 681 3513 340=20
+Q 3088 0 2303 0=20
+L 628 0=20
+L 628 4666=20
+z
+" transform=3D"scale(0.015625)"/>
+       <path id=3D"DejaVuSans-63" d=3D"M 3122 3366=20
+L 3122 2828=20
+Q 2878 2963 2633 3030=20
+Q 2388 3097 2138 3097=20
+Q 1578 3097 1268 2742=20
+Q 959 2388 959 1747=20
+Q 959 1106 1268 751=20
+Q 1578 397 2138 397=20
+Q 2388 397 2633 464=20
+Q 2878 531 3122 666=20
+L 3122 134=20
+Q 2881 22 2623 -34=20
+Q 2366 -91 2075 -91=20
+Q 1284 -91 818 406=20
+Q 353 903 353 1747=20
+Q 353 2603 823 3093=20
+Q 1294 3584 2113 3584=20
+Q 2378 3584 2631 3529=20
+Q 2884 3475 3122 3366=20
+z
+" transform=3D"scale(0.015625)"/>
+       <path id=3D"DejaVuSans-6b" d=3D"M 581 4863=20
+L 1159 4863=20
+L 1159 1991=20
+L 2875 3500=20
+L 3609 3500=20
+L 1753 1863=20
+L 3688 0=20
+L 2938 0=20
+L 1159 1709=20
+L 1159 0=20
+L 581 0=20
+L 581 4863=20
+z
+" transform=3D"scale(0.015625)"/>
+       <path id=3D"DejaVuSans-67" d=3D"M 2906 1791=20
+Q 2906 2416 2648 2759=20
+Q 2391 3103 1925 3103=20
+Q 1463 3103 1205 2759=20
+Q 947 2416 947 1791=20
+Q 947 1169 1205 825=20
+Q 1463 481 1925 481=20
+Q 2391 481 2648 825=20
+Q 2906 1169 2906 1791=20
+z
+M 3481 434=20
+Q 3481 -459 3084 -895=20
+Q 2688 -1331 1869 -1331=20
+Q 1566 -1331 1297 -1286=20
+Q 1028 -1241 775 -1147=20
+L 775 -588=20
+Q 1028 -725 1275 -790=20
+Q 1522 -856 1778 -856=20
+Q 2344 -856 2625 -561=20
+Q 2906 -266 2906 331=20
+L 2906 616=20
+Q 2728 306 2450 153=20
+Q 2172 0 1784 0=20
+Q 1141 0 747 490=20
+Q 353 981 353 1791=20
+Q 353 2603 747 3093=20
+Q 1141 3584 1784 3584=20
+Q 2172 3584 2450 3431=20
+Q 2728 3278 2906 2969=20
+L 2906 3500=20
+L 3481 3500=20
+L 3481 434=20
+z
+" transform=3D"scale(0.015625)"/>
+       <path id=3D"DejaVuSans-29" d=3D"M 513 4856=20
+L 1013 4856=20
+Q 1481 4119 1714 3412=20
+Q 1947 2706 1947 2009=20
+Q 1947 1309 1714 600=20
+Q 1481 -109 1013 -844=20
+L 513 -844=20
+Q 928 -128 1133 580=20
+Q 1338 1288 1338 2009=20
+Q 1338 2731 1133 3434=20
+Q 928 4138 513 4856=20
+z
+" transform=3D"scale(0.015625)"/>
+      </defs>
+      <use xlink:href=3D"#DejaVuSans-4f"/>
+      <use xlink:href=3D"#DejaVuSans-70" transform=3D"translate(78.710938 =
0)"/>
+      <use xlink:href=3D"#DejaVuSans-65" transform=3D"translate(142.1875 0=
)"/>
+      <use xlink:href=3D"#DejaVuSans-6e" transform=3D"translate(203.710938=
 0)"/>
+      <use xlink:href=3D"#DejaVuSans-20" transform=3D"translate(267.089844=
 0)"/>
+      <use xlink:href=3D"#DejaVuSans-49" transform=3D"translate(298.876953=
 0)"/>
+      <use xlink:href=3D"#DejaVuSans-73" transform=3D"translate(328.369141=
 0)"/>
+      <use xlink:href=3D"#DejaVuSans-73" transform=3D"translate(380.46875 =
0)"/>
+      <use xlink:href=3D"#DejaVuSans-75" transform=3D"translate(432.568359=
 0)"/>
+      <use xlink:href=3D"#DejaVuSans-65" transform=3D"translate(495.947266=
 0)"/>
+      <use xlink:href=3D"#DejaVuSans-73" transform=3D"translate(557.470703=
 0)"/>
+      <use xlink:href=3D"#DejaVuSans-20" transform=3D"translate(609.570312=
 0)"/>
+      <use xlink:href=3D"#DejaVuSans-28" transform=3D"translate(641.357422=
 0)"/>
+      <use xlink:href=3D"#DejaVuSans-42" transform=3D"translate(680.371094=
 0)"/>
+      <use xlink:href=3D"#DejaVuSans-61" transform=3D"translate(748.974609=
 0)"/>
+      <use xlink:href=3D"#DejaVuSans-63" transform=3D"translate(810.253906=
 0)"/>
+      <use xlink:href=3D"#DejaVuSans-6b" transform=3D"translate(865.234375=
 0)"/>
+      <use xlink:href=3D"#DejaVuSans-6c" transform=3D"translate(923.144531=
 0)"/>
+      <use xlink:href=3D"#DejaVuSans-6f" transform=3D"translate(950.927734=
 0)"/>
+      <use xlink:href=3D"#DejaVuSans-67" transform=3D"translate(1012.10937=
5 0)"/>
+      <use xlink:href=3D"#DejaVuSans-29" transform=3D"translate(1075.58593=
8 0)"/>
+     </g>
+    </g>
+   </g>
+  </g>
+ </g>
+ <defs>
+  <clipPath id=3D"p5b9f229a39">
+   <rect x=3D"54.295938" y=3D"29.837812" width=3D"651.04" height=3D"344.29=
0464"/>
+  </clipPath>
+ </defs>
+</svg>
diff --git a/screenshots/qemu-maint-chart-26.svg b/screenshots/qemu-maint-c=
hart-26.svg
new file mode 100644
index 0000000..e099bcf
--- /dev/null
+++ b/screenshots/qemu-maint-chart-26.svg
@@ -0,0 +1 @@
+<svg version=3D"1.1" viewBox=3D"0.0 0.0 600.0 371.0" fill=3D"none" stroke=
=3D"none" stroke-linecap=3D"square" stroke-miterlimit=3D"10" width=3D"600" =
height=3D"371" xmlns:xlink=3D"http://www.w3.org/1999/xlink" xmlns=3D"http:/=
/www.w3.org/2000/svg"><path fill=3D"#ffffff" fill-opacity=3D"0.0" d=3D"M0 0=
L600.0 0L600.0 371.0L0 371.0L0 0Z" fill-rule=3D"nonzero"/><path fill=3D"#42=
85f4" d=3D"M300.0 18.55C364.13474 18.55 422.60007 55.289448 450.42252 113.0=
7507C478.24493 170.86069 470.50555 239.47617 430.51022 289.61237L300.0 185.=
5Z" fill-rule=3D"nonzero"/><path fill=3D"#ff6d01" d=3D"M237.7586 30.586119C=
257.5466 22.635683 278.67456 18.55 300.0 18.55L300.0 185.5Z" fill-rule=3D"n=
onzero"/><path fill=3D"#34a853" d=3D"M215.94092 41.255856C222.9448 37.17431=
 230.23665 33.608295 237.7586 30.586119L300.0 185.5Z" fill-rule=3D"nonzero"=
/><path fill=3D"#fbbc04" d=3D"M144.70795 246.79178C114.43463 170.08974 144.=
69565 82.77443 215.94092 41.255856L300.0 185.5Z" fill-rule=3D"nonzero"/><pa=
th fill=3D"#ea4335" d=3D"M430.51022 289.61237C393.3531 336.19073 334.18848 =
359.43576 275.26266 350.60715C216.33685 341.77853 166.58266 302.21466 144.7=
0795 246.79178L300.0 185.5Z" fill-rule=3D"nonzero"/><path fill=3D"#1a1a1a" =
d=3D"M25.1125 20.95625L26.253124 20.95625L26.253124 25.925Q26.253124 27.221=
874 25.95625 27.9875Q25.659374 28.7375 24.89375 29.221874Q24.128124 29.6906=
24 22.89375 29.690624Q21.690624 29.690624 20.909374 29.284374Q20.14375 28.8=
625 19.815624 28.08125Q19.4875 27.284374 19.4875 25.925L19.4875 20.95625L20=
.628124 20.95625L20.628124 25.909374Q20.628124 27.034374 20.83125 27.565624=
Q21.05 28.096874 21.55 28.39375Q22.065624 28.675 22.8 28.675Q24.05 28.675 2=
4.58125 28.1125Q25.1125 27.534374 25.1125 25.909374L25.1125 20.95625ZM28.34=
6874 29.55L28.346874 23.33125L29.284374 23.33125L29.284374 24.20625Q29.9718=
74 23.190624 31.26875 23.190624Q31.83125 23.190624 32.3 23.39375Q32.784374 =
23.596874 33.01875 23.925Q33.253124 24.253124 33.346874 24.690624Q33.39375 =
24.9875 33.39375 25.721874L33.39375 29.55L32.346874 29.55L32.346874 25.7687=
5Q32.346874 25.1125 32.221874 24.8Q32.096874 24.4875 31.784374 24.3Q31.4718=
74 24.096874 31.05 24.096874Q30.378124 24.096874 29.878124 24.534374Q29.393=
75 24.95625 29.39375 26.14375L29.39375 29.55L28.346874 29.55ZM35.346874 29.=
55L35.346874 20.95625L36.409374 20.95625L36.409374 25.8625L38.89375 23.3312=
5L40.26875 23.33125L37.878124 25.628124L40.503124 29.55L39.20625 29.55L37.1=
4375 26.3625L36.409374 27.08125L36.409374 29.55L35.346874 29.55ZM41.346874 =
29.55L41.346874 23.33125L42.284374 23.33125L42.284374 24.20625Q42.971874 23=
.190624 44.26875 23.190624Q44.83125 23.190624 45.3 23.39375Q45.784374 23.59=
6874 46.01875 23.925Q46.253124 24.253124 46.346874 24.690624Q46.39375 24.98=
75 46.39375 25.721874L46.39375 29.55L45.346874 29.55L45.346874 25.76875Q45.=
346874 25.1125 45.221874 24.8Q45.096874 24.4875 44.784374 24.3Q44.471874 24=
.096874 44.05 24.096874Q43.378124 24.096874 42.878124 24.534374Q42.39375 24=
.95625 42.39375 26.14375L42.39375 29.55L41.346874 29.55ZM47.95625 26.440624=
Q47.95625 24.70625 48.909374 23.878124Q49.70625 23.190624 50.8625 23.190624=
Q52.14375 23.190624 52.95625 24.034374Q53.784374 24.8625 53.784374 26.34687=
4Q53.784374 27.55 53.425 28.2375Q53.065624 28.925 52.3625 29.315624Q51.675 =
29.690624 50.8625 29.690624Q49.565624 29.690624 48.753124 28.8625Q47.95625 =
28.01875 47.95625 26.440624ZM49.034374 26.440624Q49.034374 27.628124 49.55 =
28.221874Q50.08125 28.815624 50.8625 28.815624Q51.659374 28.815624 52.175 2=
8.221874Q52.690624 27.628124 52.690624 26.409374Q52.690624 25.253124 52.159=
374 24.659374Q51.64375 24.065624 50.8625 24.065624Q50.08125 24.065624 49.55=
 24.659374Q49.034374 25.2375 49.034374 26.440624ZM56.4875 29.55L54.58125 23=
.33125L55.675 23.33125L56.659374 26.925L57.034374 28.253124Q57.065624 28.15=
9374 57.3625 26.971874L58.346874 23.33125L59.425 23.33125L60.3625 26.940624=
L60.675 28.128124L61.034374 26.925L62.096874 23.33125L63.128124 23.33125L61=
.175 29.55L60.08125 29.55L59.096874 25.815624L58.846874 24.76875L57.596874 =
29.55L56.4875 29.55ZM64.34688 29.55L64.34688 23.33125L65.28438 23.33125L65.=
28438 24.20625Q65.97188 23.190624 67.26875 23.190624Q67.83125 23.190624 68.=
3 23.39375Q68.78438 23.596874 69.01875 23.925Q69.25313 24.253124 69.34688 2=
4.690624Q69.39375 24.9875 69.39375 25.721874L69.39375 29.55L68.34688 29.55L=
68.34688 25.76875Q68.34688 25.1125 68.22188 24.8Q68.09688 24.4875 67.78438 =
24.3Q67.47188 24.096874 67.05 24.096874Q66.37813 24.096874 65.87813 24.5343=
74Q65.39375 24.95625 65.39375 26.14375L65.39375 29.55L64.34688 29.55Z" fill=
-rule=3D"nonzero"/><path fill=3D"#9e9e9e" d=3D"M24.51875 40.065624L23.47187=
4 40.14375Q23.33125 39.51875 23.08125 39.2375Q22.64375 38.784374 22.01875 3=
8.784374Q21.51875 38.784374 21.128124 39.065624Q20.64375 39.440624 20.34687=
4 40.14375Q20.065624 40.83125 20.05 42.1125Q20.425 41.534374 20.971874 41.2=
53124Q21.534374 40.971874 22.14375 40.971874Q23.190624 40.971874 23.925 41.=
753124Q24.675 42.534374 24.675 43.753124Q24.675 44.565624 24.315624 45.2687=
5Q23.971874 45.95625 23.3625 46.33125Q22.753124 46.690624 21.9875 46.690624=
Q20.659374 46.690624 19.83125 45.721874Q19.003124 44.753124 19.003124 42.53=
4374Q19.003124 40.034374 19.925 38.909374Q20.721874 37.925 22.08125 37.925Q=
23.096874 37.925 23.7375 38.503124Q24.39375 39.065624 24.51875 40.065624ZM2=
0.221874 43.76875Q20.221874 44.315624 20.440624 44.815624Q20.675 45.3 21.08=
125 45.565624Q21.503124 45.83125 21.971874 45.83125Q22.628124 45.83125 23.1=
125 45.3Q23.596874 44.753124 23.596874 43.83125Q23.596874 42.940624 23.1125=
 42.425Q22.64375 41.909374 21.925 41.909374Q21.20625 41.909374 20.70625 42.=
425Q20.221874 42.940624 20.221874 43.76875ZM26.64375 46.55L26.64375 45.3468=
74L27.846874 45.346874L27.846874 46.55L26.64375 46.55ZM33.01875 46.55L31.97=
1874 46.55L31.971874 39.83125Q31.58125 40.190624 30.95625 40.565624Q30.3468=
74 40.925 29.8625 41.096874L29.8625 40.08125Q30.7375 39.659374 31.39375 39.=
08125Q32.065624 38.4875 32.346874 37.925L33.01875 37.925L33.01875 46.55ZM36=
.253124 40.01875Q36.253124 39.096874 36.70625 38.45625Q37.175 37.815624 38.=
05 37.815624Q38.8625 37.815624 39.39375 38.39375Q39.925 38.971874 39.925 40=
.08125Q39.925 41.175 39.378124 41.76875Q38.846874 42.346874 38.065624 42.34=
6874Q37.284374 42.346874 36.76875 41.76875Q36.253124 41.190624 36.253124 40=
.01875ZM38.08125 38.534374Q37.690624 38.534374 37.425 38.878124Q37.175 39.2=
21874 37.175 40.128124Q37.175 40.95625 37.425 41.3Q37.690624 41.628124 38.0=
8125 41.628124Q38.4875 41.628124 38.7375 41.284374Q39.003124 40.940624 39.0=
03124 40.05Q39.003124 39.20625 38.7375 38.878124Q38.471874 38.534374 38.081=
25 38.534374ZM38.08125 46.8625L42.784374 37.815624L43.64375 37.815624L38.95=
625 46.8625L38.08125 46.8625ZM41.8 44.534374Q41.8 43.6125 42.253124 42.9718=
74Q42.721874 42.33125 43.6125 42.33125Q44.425 42.33125 44.95625 42.909374Q4=
5.4875 43.471874 45.4875 44.596874Q45.4875 45.690624 44.940624 46.284374Q44=
.409374 46.8625 43.6125 46.8625Q42.846874 46.8625 42.315624 46.284374Q41.8 =
45.70625 41.8 44.534374ZM43.64375 43.05Q43.2375 43.05 42.971874 43.39375Q42=
.721874 43.7375 42.721874 44.64375Q42.721874 45.45625 42.9875 45.8Q43.25312=
4 46.14375 43.64375 46.14375Q44.034374 46.14375 44.3 45.8Q44.565624 45.4562=
5 44.565624 44.55Q44.565624 43.721874 44.3 43.39375Q44.034374 43.05 43.6437=
5 43.05Z" fill-rule=3D"nonzero"/><path stroke=3D"#757575" stroke-width=3D"1=
.0" stroke-linecap=3D"butt" d=3D"M18.55 34.05L127.05 34.05L269.88763 29.782=
314" fill-rule=3D"nonzero"/><path fill=3D"#9e9e9e" d=3D"M271.88763 29.78231=
4C271.88763 28.677744 270.9922 27.782314 269.88763 27.782314C268.78305 27.7=
82314 267.88763 28.677744 267.88763 29.782314C267.88763 30.886883 268.78305=
 31.782314 269.88763 31.782314C270.9922 31.782314 271.88763 30.886883 271.8=
8763 29.782314" fill-rule=3D"nonzero"/><path fill=3D"#1a1a1a" d=3D"M19.1281=
24 56.3625Q19.128124 54.221874 20.26875 53.01875Q21.425 51.8 23.2375 51.8Q2=
4.440624 51.8 25.39375 52.378124Q26.346874 52.940624 26.846874 53.95625Q27.=
346874 54.971874 27.346874 56.26875Q27.346874 57.565624 26.815624 58.596874=
Q26.284374 59.628124 25.315624 60.159374Q24.3625 60.690624 23.2375 60.69062=
4Q22.01875 60.690624 21.065624 60.1125Q20.1125 59.51875 19.6125 58.51875Q19=
.128124 57.503124 19.128124 56.3625ZM20.3 56.378124Q20.3 57.940624 21.12812=
4 58.83125Q21.971874 59.721874 23.2375 59.721874Q24.51875 59.721874 25.3468=
74 58.83125Q26.175 57.925 26.175 56.253124Q26.175 55.20625 25.815624 54.425=
Q25.471874 53.64375 24.784374 53.221874Q24.096874 52.784374 23.253124 52.78=
4374Q22.05 52.784374 21.175 53.6125Q20.3 54.440624 20.3 56.378124ZM28.33125=
 60.55L28.33125 54.33125L29.284374 54.33125L29.284374 55.26875Q29.64375 54.=
6125 29.940624 54.409374Q30.253124 54.190624 30.628124 54.190624Q31.159374 =
54.190624 31.70625 54.51875L31.346874 55.503124Q30.95625 55.26875 30.58125 =
55.26875Q30.221874 55.26875 29.940624 55.4875Q29.675 55.690624 29.565624 56=
.065624Q29.378124 56.628124 29.378124 57.284374L29.378124 60.55L28.33125 60=
.55ZM32.346874 62.940624L32.346874 54.33125L33.3 54.33125L33.3 55.128124Q33=
.64375 54.659374 34.065624 54.425Q34.503124 54.190624 35.1125 54.190624Q35.=
909374 54.190624 36.51875 54.596874Q37.128124 55.003124 37.425 55.753124Q37=
.7375 56.503124 37.7375 57.39375Q37.7375 58.346874 37.39375 59.1125Q37.0656=
24 59.878124 36.409374 60.284374Q35.753124 60.690624 35.034374 60.690624Q34=
.503124 60.690624 34.08125 60.471874Q33.659374 60.2375 33.39375 59.909374L3=
3.39375 62.940624L32.346874 62.940624ZM33.3 57.471874Q33.3 58.675 33.784374=
 59.253124Q34.26875 59.815624 34.95625 59.815624Q35.659374 59.815624 36.159=
374 59.221874Q36.659374 58.628124 36.659374 57.378124Q36.659374 56.190624 3=
6.175 55.6125Q35.690624 55.01875 35.003124 55.01875Q34.33125 55.01875 33.81=
5624 55.64375Q33.3 56.26875 33.3 57.471874ZM39.346874 60.55L39.346874 51.95=
625L40.39375 51.95625L40.39375 55.034374Q41.128124 54.190624 42.253124 54.1=
90624Q42.95625 54.190624 43.45625 54.471874Q43.971874 54.7375 44.190624 55.=
221874Q44.409374 55.690624 44.409374 56.6125L44.409374 60.55L43.3625 60.55L=
43.3625 56.6125Q43.3625 55.815624 43.01875 55.45625Q42.675 55.096874 42.05 =
55.096874Q41.58125 55.096874 41.159374 55.346874Q40.753124 55.58125 40.5656=
24 56.003124Q40.39375 56.409374 40.39375 57.14375L40.39375 60.55L39.346874 =
60.55ZM50.409374 59.784374Q49.815624 60.284374 49.26875 60.4875Q48.7375 60.=
690624 48.1125 60.690624Q47.08125 60.690624 46.534374 60.190624Q45.9875 59.=
690624 45.9875 58.909374Q45.9875 58.45625 46.190624 58.08125Q46.39375 57.69=
0624 46.7375 57.471874Q47.08125 57.2375 47.503124 57.128124Q47.8 57.034374 =
48.440624 56.95625Q49.70625 56.815624 50.315624 56.596874Q50.315624 56.3781=
24 50.315624 56.33125Q50.315624 55.675 50.01875 55.409374Q49.6125 55.065624=
 48.815624 55.065624Q48.08125 55.065624 47.721874 55.33125Q47.3625 55.58125=
 47.190624 56.2375L46.159374 56.096874Q46.3 55.440624 46.628124 55.034374Q4=
6.95625 54.628124 47.565624 54.409374Q48.175 54.190624 48.971874 54.190624Q=
49.76875 54.190624 50.26875 54.378124Q50.76875 54.565624 51.003124 54.84687=
4Q51.2375 55.128124 51.33125 55.565624Q51.378124 55.83125 51.378124 56.5343=
74L51.378124 57.940624Q51.378124 59.409374 51.440624 59.8Q51.51875 60.19062=
4 51.721874 60.55L50.6125 60.55Q50.45625 60.221874 50.409374 59.784374ZM50.=
315624 57.425Q49.7375 57.659374 48.596874 57.83125Q47.940624 57.925 47.675 =
58.05Q47.409374 58.159374 47.253124 58.378124Q47.1125 58.596874 47.1125 58.=
878124Q47.1125 59.3 47.425 59.58125Q47.753124 59.8625 48.3625 59.8625Q48.97=
1874 59.8625 49.440624 59.596874Q49.925 59.33125 50.14375 58.8625Q50.315624=
 58.503124 50.315624 57.815624L50.315624 57.425ZM53.346874 60.55L53.346874 =
54.33125L54.284374 54.33125L54.284374 55.20625Q54.971874 54.190624 56.26875=
 54.190624Q56.83125 54.190624 57.3 54.39375Q57.784374 54.596874 58.01875 54=
.925Q58.253124 55.253124 58.346874 55.690624Q58.39375 55.9875 58.39375 56.7=
21874L58.39375 60.55L57.346874 60.55L57.346874 56.76875Q57.346874 56.1125 5=
7.221874 55.8Q57.096874 55.4875 56.784374 55.3Q56.471874 55.096874 56.05 55=
.096874Q55.378124 55.096874 54.878124 55.534374Q54.39375 55.95625 54.39375 =
57.14375L54.39375 60.55L53.346874 60.55Z" fill-rule=3D"nonzero"/><path fill=
=3D"#9e9e9e" d=3D"M24.596874 76.53438L24.596874 77.55L18.909374 77.55Q18.90=
9374 77.175 19.034374 76.81563Q19.253124 76.2375 19.721874 75.675Q20.20625 =
75.1125 21.1125 74.37813Q22.51875 73.22188 23.003124 72.55Q23.503124 71.878=
13 23.503124 71.28438Q23.503124 70.65938 23.05 70.2375Q22.596874 69.8 21.87=
8124 69.8Q21.1125 69.8 20.659374 70.25313Q20.20625 70.70625 20.190624 71.51=
875L19.1125 71.40938Q19.221874 70.19063 19.940624 69.56563Q20.675 68.925 21=
.909374 68.925Q23.14375 68.925 23.8625 69.6125Q24.58125 70.3 24.58125 71.31=
563Q24.58125 71.83125 24.3625 72.33125Q24.159374 72.81563 23.659374 73.3781=
3Q23.175 73.925 22.05 74.87813Q21.096874 75.675 20.815624 75.97188Q20.55 76=
.25313 20.378124 76.53438L24.596874 76.53438ZM26.64375 77.55L26.64375 76.34=
688L27.846874 76.34688L27.846874 77.55L26.64375 77.55ZM29.05 75.28438L30.11=
25 75.14375Q30.284374 76.03438 30.721874 76.44063Q31.159374 76.83125 31.784=
374 76.83125Q32.534374 76.83125 33.05 76.31563Q33.565624 75.8 33.565624 75.=
03438Q33.565624 74.31563 33.08125 73.84688Q32.6125 73.3625 31.878124 73.362=
5Q31.58125 73.3625 31.128124 73.4875L31.253124 72.55Q31.3625 72.56563 31.42=
5 72.56563Q32.096874 72.56563 32.628124 72.22188Q33.175 71.8625 33.175 71.1=
2813Q33.175 70.55 32.784374 70.175Q32.39375 69.78438 31.76875 69.78438Q31.1=
59374 69.78438 30.7375 70.175Q30.33125 70.56563 30.221874 71.33125L29.15937=
4 71.14375Q29.346874 70.09688 30.034374 69.51875Q30.721874 68.925 31.7375 6=
8.925Q32.440624 68.925 33.034374 69.2375Q33.628124 69.53438 33.940624 70.05=
Q34.253124 70.56563 34.253124 71.15938Q34.253124 71.70625 33.95625 72.175Q3=
3.659374 72.62813 33.08125 72.89375Q33.83125 73.06563 34.253124 73.62813Q34=
.675 74.175 34.675 75.01875Q34.675 76.14375 33.846874 76.925Q33.034374 77.7=
0625 31.784374 77.70625Q30.659374 77.70625 29.909374 77.03438Q29.159374 76.=
34688 29.05 75.28438ZM36.253124 71.01875Q36.253124 70.09688 36.70625 69.456=
25Q37.175 68.81563 38.05 68.81563Q38.8625 68.81563 39.39375 69.39375Q39.925=
 69.97188 39.925 71.08125Q39.925 72.175 39.378124 72.76875Q38.846874 73.346=
88 38.065624 73.34688Q37.284374 73.34688 36.76875 72.76875Q36.253124 72.190=
63 36.253124 71.01875ZM38.08125 69.53438Q37.690624 69.53438 37.425 69.87813=
Q37.175 70.22188 37.175 71.12813Q37.175 71.95625 37.425 72.3Q37.690624 72.6=
2813 38.08125 72.62813Q38.4875 72.62813 38.7375 72.28438Q39.003124 71.94063=
 39.003124 71.05Q39.003124 70.20625 38.7375 69.87813Q38.471874 69.53438 38.=
08125 69.53438ZM38.08125 77.8625L42.784374 68.81563L43.64375 68.81563L38.95=
625 77.8625L38.08125 77.8625ZM41.8 75.53438Q41.8 74.6125 42.253124 73.97188=
Q42.721874 73.33125 43.6125 73.33125Q44.425 73.33125 44.95625 73.90938Q45.4=
875 74.47188 45.4875 75.59688Q45.4875 76.69063 44.940624 77.28438Q44.409374=
 77.8625 43.6125 77.8625Q42.846874 77.8625 42.315624 77.28438Q41.8 76.70625=
 41.8 75.53438ZM43.64375 74.05Q43.2375 74.05 42.971874 74.39375Q42.721874 7=
4.7375 42.721874 75.64375Q42.721874 76.45625 42.9875 76.8Q43.253124 77.1437=
5 43.64375 77.14375Q44.034374 77.14375 44.3 76.8Q44.565624 76.45625 44.5656=
24 75.55Q44.565624 74.72188 44.3 74.39375Q44.034374 74.05 43.64375 74.05Z" =
fill-rule=3D"nonzero"/><path stroke=3D"#757575" stroke-width=3D"1.0" stroke=
-linecap=3D"butt" d=3D"M18.55 65.05L127.05 65.05L230.32271 43.022537" fill-=
rule=3D"nonzero"/><path fill=3D"#9e9e9e" d=3D"M232.32271 43.022537C232.3227=
1 41.917965 231.42728 41.022537 230.32271 41.022537C229.21814 41.022537 228=
.32271 41.917965 228.32271 43.022537C228.32271 44.127106 229.21814 45.02253=
7 230.32271 45.022537C231.42728 45.022537 232.32271 44.127106 232.32271 43.=
022537" fill-rule=3D"nonzero"/><path fill=3D"#1a1a1a" d=3D"M19.128124 124.8=
7602Q19.128124 122.7354 20.26875 121.53227Q21.425 120.31352 23.2375 120.313=
52Q24.440624 120.31352 25.39375 120.89165Q26.346874 121.45415 26.846874 122=
.46977Q27.346874 123.4854 27.346874 124.78227Q27.346874 126.07915 26.815624=
 127.1104Q26.284374 128.14165 25.315624 128.6729Q24.3625 129.20415 23.2375 =
129.20415Q22.01875 129.20415 21.065624 128.62602Q20.1125 128.03227 19.6125 =
127.03227Q19.128124 126.01665 19.128124 124.87602ZM20.3 124.89165Q20.3 126.=
45415 21.128124 127.34477Q21.971874 128.2354 23.2375 128.2354Q24.51875 128.=
2354 25.346874 127.34477Q26.175 126.43852 26.175 124.76665Q26.175 123.71977=
 25.815624 122.93852Q25.471874 122.15727 24.784374 121.7354Q24.096874 121.2=
979 23.253124 121.2979Q22.05 121.2979 21.175 122.12602Q20.3 122.95415 20.3 =
124.89165ZM32.378124 129.06352L32.378124 128.28227Q31.784374 129.20415 30.6=
4375 129.20415Q29.89375 129.20415 29.26875 128.7979Q28.64375 128.37602 28.3=
 127.64165Q27.95625 126.90727 27.95625 125.95415Q27.95625 125.03227 28.2687=
5 124.26665Q28.58125 123.50102 29.20625 123.1104Q29.83125 122.70415 30.5968=
74 122.70415Q31.159374 122.70415 31.596874 122.93852Q32.034374 123.1729 32.=
315624 123.5479L32.315624 120.46977L33.3625 120.46977L33.3625 129.06352L32.=
378124 129.06352ZM29.05 125.95415Q29.05 127.15727 29.55 127.75102Q30.05 128=
.32915 30.7375 128.32915Q31.425 128.32915 31.909374 127.76665Q32.39375 127.=
20415 32.39375 126.0479Q32.39375 124.76665 31.89375 124.1729Q31.409374 123.=
57915 30.690624 123.57915Q29.9875 123.57915 29.51875 124.15727Q29.05 124.71=
977 29.05 125.95415ZM39.378124 129.06352L39.378124 128.28227Q38.784374 129.=
20415 37.64375 129.20415Q36.89375 129.20415 36.26875 128.7979Q35.64375 128.=
37602 35.3 127.64165Q34.95625 126.90727 34.95625 125.95415Q34.95625 125.032=
27 35.26875 124.26665Q35.58125 123.50102 36.20625 123.1104Q36.83125 122.704=
15 37.596874 122.70415Q38.159374 122.70415 38.596874 122.93852Q39.034374 12=
3.1729 39.315624 123.5479L39.315624 120.46977L40.3625 120.46977L40.3625 129=
.06352L39.378124 129.06352ZM36.05 125.95415Q36.05 127.15727 36.55 127.75102=
Q37.05 128.32915 37.7375 128.32915Q38.425 128.32915 38.909374 127.76665Q39.=
39375 127.20415 39.39375 126.0479Q39.39375 124.76665 38.89375 124.1729Q38.4=
09374 123.57915 37.690624 123.57915Q36.9875 123.57915 36.51875 124.15727Q36=
.05 124.71977 36.05 125.95415ZM45.534374 129.06352L45.534374 120.46977L51.3=
3125 120.46977L51.33125 121.4854L46.675 121.4854L46.675 124.14165L50.70625 =
124.14165L50.70625 125.15727L46.675 125.15727L46.675 129.06352L45.534374 12=
9.06352ZM52.346874 121.68852L52.346874 120.46977L53.409374 120.46977L53.409=
374 121.68852L52.346874 121.68852ZM52.346874 129.06352L52.346874 122.84477L=
53.409374 122.84477L53.409374 129.06352L52.346874 129.06352ZM54.64375 129.0=
6352L56.909374 125.82915L54.815624 122.84477L56.128124 122.84477L57.08125 1=
24.2979Q57.346874 124.71977 57.51875 125.00102Q57.76875 124.6104 57.9875 12=
4.31352L59.034374 122.84477L60.3 122.84477L58.14375 125.76665L60.45625 129.=
06352L59.175 129.06352L57.89375 127.12602L57.55 126.6104L55.909374 129.0635=
2L54.64375 129.06352ZM65.59688 127.06352L66.69063 127.18852Q66.44063 128.14=
165 65.7375 128.6729Q65.03438 129.20415 63.95625 129.20415Q62.596874 129.20=
415 61.784374 128.3604Q60.9875 127.51665 60.9875 126.00102Q60.9875 124.4385=
2 61.8 123.57915Q62.6125 122.70415 63.89375 122.70415Q65.14375 122.70415 65=
.925 123.5479Q66.72188 124.39165 66.72188 125.93852Q66.72188 126.03227 66.7=
2188 126.21977L62.08125 126.21977Q62.14375 127.25102 62.659374 127.7979Q63.=
175 128.32915 63.95625 128.32915Q64.53438 128.32915 64.94063 128.03227Q65.3=
625 127.71977 65.59688 127.06352ZM62.14375 125.3604L65.6125 125.3604Q65.55 =
124.56352 65.22188 124.1729Q64.70625 123.56352 63.909374 123.56352Q63.175 1=
23.56352 62.675 124.0479Q62.190624 124.53227 62.14375 125.3604ZM67.925 127.=
20415L68.95625 127.0479Q69.05 127.6729 69.44063 128.00102Q69.84688 128.3291=
5 70.58125 128.32915Q71.3 128.32915 71.64375 128.0479Q72.00313 127.75102 72=
.00313 127.34477Q72.00313 126.9854 71.69063 126.78227Q71.47188 126.64165 70=
.6125 126.4229Q69.45625 126.12602 69.00313 125.9229Q68.56563 125.70415 68.3=
3125 125.32915Q68.09688 124.95415 68.09688 124.4854Q68.09688 124.07915 68.2=
8438 123.71977Q68.47188 123.3604 68.8 123.12602Q69.05 122.95415 69.47188 12=
2.82915Q69.89375 122.70415 70.39375 122.70415Q71.1125 122.70415 71.65938 12=
2.9229Q72.22188 123.12602 72.4875 123.4854Q72.75313 123.84477 72.84688 124.=
43852L71.81563 124.57915Q71.75313 124.1104 71.40938 123.84477Q71.08125 123.=
56352 70.45625 123.56352Q69.7375 123.56352 69.425 123.81352Q69.1125 124.047=
9 69.1125 124.37602Q69.1125 124.57915 69.2375 124.7354Q69.37813 124.90727 6=
9.64375 125.01665Q69.8 125.07915 70.58125 125.28227Q71.70625 125.59477 72.1=
4375 125.78227Q72.58125 125.96977 72.83125 126.32915Q73.08125 126.68852 73.=
08125 127.2354Q73.08125 127.76665 72.76875 128.2354Q72.47188 128.68852 71.8=
9375 128.95415Q71.31563 129.20415 70.58125 129.20415Q69.3625 129.20415 68.7=
2188 128.70415Q68.09688 128.18852 67.925 127.20415Z" fill-rule=3D"nonzero"/=
><path fill=3D"#9e9e9e" d=3D"M24.596874 145.0479L24.596874 146.06352L18.909=
374 146.06352Q18.909374 145.68852 19.034374 145.32915Q19.253124 144.75102 1=
9.721874 144.18852Q20.20625 143.62602 21.1125 142.89165Q22.51875 141.7354 2=
3.003124 141.06352Q23.503124 140.39165 23.503124 139.7979Q23.503124 139.172=
9 23.05 138.75102Q22.596874 138.31352 21.878124 138.31352Q21.1125 138.31352=
 20.659374 138.76665Q20.20625 139.21977 20.190624 140.03227L19.1125 139.922=
9Q19.221874 138.70415 19.940624 138.07915Q20.675 137.43852 21.909374 137.43=
852Q23.14375 137.43852 23.8625 138.12602Q24.58125 138.81352 24.58125 139.82=
915Q24.58125 140.34477 24.3625 140.84477Q24.159374 141.32915 23.659374 141.=
89165Q23.175 142.43852 22.05 143.39165Q21.096874 144.18852 20.815624 144.48=
54Q20.55 144.76665 20.378124 145.0479L24.596874 145.0479ZM31.596874 145.047=
9L31.596874 146.06352L25.909374 146.06352Q25.909374 145.68852 26.034374 145=
.32915Q26.253124 144.75102 26.721874 144.18852Q27.20625 143.62602 28.1125 1=
42.89165Q29.51875 141.7354 30.003124 141.06352Q30.503124 140.39165 30.50312=
4 139.7979Q30.503124 139.1729 30.05 138.75102Q29.596874 138.31352 28.878124=
 138.31352Q28.1125 138.31352 27.659374 138.76665Q27.20625 139.21977 27.1906=
24 140.03227L26.1125 139.9229Q26.221874 138.70415 26.940624 138.07915Q27.67=
5 137.43852 28.909374 137.43852Q30.14375 137.43852 30.8625 138.12602Q31.581=
25 138.81352 31.58125 139.82915Q31.58125 140.34477 31.3625 140.84477Q31.159=
374 141.32915 30.659374 141.89165Q30.175 142.43852 29.05 143.39165Q28.09687=
4 144.18852 27.815624 144.4854Q27.55 144.76665 27.378124 145.0479L31.596874=
 145.0479ZM33.64375 146.06352L33.64375 144.8604L34.846874 144.8604L34.84687=
4 146.06352L33.64375 146.06352ZM41.51875 139.57915L40.471874 139.65727Q40.3=
3125 139.03227 40.08125 138.75102Q39.64375 138.2979 39.01875 138.2979Q38.51=
875 138.2979 38.128124 138.57915Q37.64375 138.95415 37.346874 139.65727Q37.=
065624 140.34477 37.05 141.62602Q37.425 141.0479 37.971874 140.76665Q38.534=
374 140.4854 39.14375 140.4854Q40.190624 140.4854 40.925 141.26665Q41.675 1=
42.0479 41.675 143.26665Q41.675 144.07915 41.315624 144.78227Q40.971874 145=
.46977 40.3625 145.84477Q39.753124 146.20415 38.9875 146.20415Q37.659374 14=
6.20415 36.83125 145.2354Q36.003124 144.26665 36.003124 142.0479Q36.003124 =
139.5479 36.925 138.4229Q37.721874 137.43852 39.08125 137.43852Q40.096874 1=
37.43852 40.7375 138.01665Q41.39375 138.57915 41.51875 139.57915ZM37.221874=
 143.28227Q37.221874 143.82915 37.440624 144.32915Q37.675 144.81352 38.0812=
5 145.07915Q38.503124 145.34477 38.971874 145.34477Q39.628124 145.34477 40.=
1125 144.81352Q40.596874 144.26665 40.596874 143.34477Q40.596874 142.45415 =
40.1125 141.93852Q39.64375 141.4229 38.925 141.4229Q38.20625 141.4229 37.70=
625 141.93852Q37.221874 142.45415 37.221874 143.28227ZM43.253124 139.53227Q=
43.253124 138.6104 43.70625 137.96977Q44.175 137.32915 45.05 137.32915Q45.8=
625 137.32915 46.39375 137.90727Q46.925 138.4854 46.925 139.59477Q46.925 14=
0.68852 46.378124 141.28227Q45.846874 141.8604 45.065624 141.8604Q44.284374=
 141.8604 43.76875 141.28227Q43.253124 140.70415 43.253124 139.53227ZM45.08=
125 138.0479Q44.690624 138.0479 44.425 138.39165Q44.175 138.7354 44.175 139=
.64165Q44.175 140.46977 44.425 140.81352Q44.690624 141.14165 45.08125 141.1=
4165Q45.4875 141.14165 45.7375 140.7979Q46.003124 140.45415 46.003124 139.5=
6352Q46.003124 138.71977 45.7375 138.39165Q45.471874 138.0479 45.08125 138.=
0479ZM45.08125 146.37602L49.784374 137.32915L50.64375 137.32915L45.95625 14=
6.37602L45.08125 146.37602ZM48.8 144.0479Q48.8 143.12602 49.253124 142.4854=
Q49.721874 141.84477 50.6125 141.84477Q51.425 141.84477 51.95625 142.4229Q5=
2.4875 142.9854 52.4875 144.1104Q52.4875 145.20415 51.940624 145.7979Q51.40=
9374 146.37602 50.6125 146.37602Q49.846874 146.37602 49.315624 145.7979Q48.=
8 145.21977 48.8 144.0479ZM50.64375 142.56352Q50.2375 142.56352 49.971874 1=
42.90727Q49.721874 143.25102 49.721874 144.15727Q49.721874 144.96977 49.987=
5 145.31352Q50.253124 145.65727 50.64375 145.65727Q51.034374 145.65727 51.3=
 145.31352Q51.565624 144.96977 51.565624 144.06352Q51.565624 143.2354 51.3 =
142.90727Q51.034374 142.56352 50.64375 142.56352Z" fill-rule=3D"nonzero"/><=
path stroke=3D"#757575" stroke-width=3D"1.0" stroke-linecap=3D"butt" d=3D"M=
18.55 133.56352L127.05 133.56352L150.14221 133.56352" fill-rule=3D"nonzero"=
/><path fill=3D"#9e9e9e" d=3D"M152.14221 133.56352C152.14221 132.45895 151.=
2468 131.56352 150.14221 131.56352C149.03764 131.56352 148.14221 132.45895 =
148.14221 133.56352C148.14221 134.66809 149.03764 135.56352 150.14221 135.5=
6352C151.2468 135.56352 152.14221 134.66809 152.14221 133.56352" fill-rule=
=3D"nonzero"/><path fill=3D"#1a1a1a" d=3D"M19.096874 329.6844L20.159374 329=
.59064Q20.2375 330.2469 20.51875 330.65314Q20.8 331.0594 21.378124 331.325Q=
21.971874 331.575 22.70625 331.575Q23.346874 331.575 23.846874 331.3875Q24.=
346874 331.1844 24.58125 330.85626Q24.83125 330.5125 24.83125 330.1219Q24.8=
3125 329.71564 24.596874 329.41876Q24.3625 329.10626 23.83125 328.90314Q23.=
471874 328.7625 22.284374 328.48126Q21.1125 328.2 20.64375 327.95Q20.01875 =
327.6219 19.721874 327.15314Q19.425 326.66876 19.425 326.075Q19.425 325.434=
4 19.784374 324.8719Q20.159374 324.29376 20.8625 324.0125Q21.58125 323.7156=
4 22.440624 323.71564Q23.39375 323.71564 24.128124 324.02814Q24.8625 324.32=
5 25.253124 324.9344Q25.64375 325.52814 25.675 326.27814L24.58125 326.35626=
Q24.4875 325.54376 23.971874 325.1375Q23.471874 324.71564 22.4875 324.71564=
Q21.45625 324.71564 20.9875 325.09064Q20.51875 325.46564 20.51875 325.9969Q=
20.51875 326.46564 20.846874 326.7625Q21.175 327.0594 22.55 327.3719Q23.940=
624 327.6844 24.45625 327.91876Q25.20625 328.27814 25.565624 328.8094Q25.92=
5 329.325 25.925 330.02814Q25.925 330.71564 25.534374 331.325Q25.14375 331.=
91876 24.409374 332.2625Q23.675 332.59064 22.753124 332.59064Q21.58125 332.=
59064 20.784374 332.2625Q20.003124 331.91876 19.55 331.23126Q19.1125 330.54=
376 19.096874 329.6844ZM31.425 332.45L31.425 331.52814Q30.690624 332.59064 =
29.440624 332.59064Q28.89375 332.59064 28.409374 332.3875Q27.940624 332.168=
76 27.70625 331.85626Q27.471874 331.52814 27.378124 331.0594Q27.315624 330.=
7625 27.315624 330.075L27.315624 326.23126L28.378124 326.23126L28.378124 32=
9.6844Q28.378124 330.4969 28.440624 330.79376Q28.534374 331.2 28.846874 331=
.45Q29.175 331.6844 29.659374 331.6844Q30.128124 331.6844 30.534374 331.45Q=
30.95625 331.2 31.128124 330.77814Q31.315624 330.35626 31.315624 329.5594L3=
1.315624 326.23126L32.3625 326.23126L32.3625 332.45L31.425 332.45ZM34.34687=
4 334.84064L34.346874 326.23126L35.3 326.23126L35.3 327.02814Q35.64375 326.=
5594 36.065624 326.325Q36.503124 326.09064 37.1125 326.09064Q37.909374 326.=
09064 38.51875 326.4969Q39.128124 326.90314 39.425 327.65314Q39.7375 328.40=
314 39.7375 329.29376Q39.7375 330.2469 39.39375 331.0125Q39.065624 331.7781=
4 38.409374 332.1844Q37.753124 332.59064 37.034374 332.59064Q36.503124 332.=
59064 36.08125 332.3719Q35.659374 332.1375 35.39375 331.8094L35.39375 334.8=
4064L34.346874 334.84064ZM35.3 329.3719Q35.3 330.575 35.784374 331.15314Q36=
.26875 331.71564 36.95625 331.71564Q37.659374 331.71564 38.159374 331.1219Q=
38.659374 330.52814 38.659374 329.27814Q38.659374 328.09064 38.175 327.5125=
Q37.690624 326.91876 37.003124 326.91876Q36.33125 326.91876 35.815624 327.5=
4376Q35.3 328.16876 35.3 329.3719ZM41.346874 334.84064L41.346874 326.23126L=
42.3 326.23126L42.3 327.02814Q42.64375 326.5594 43.065624 326.325Q43.503124=
 326.09064 44.1125 326.09064Q44.909374 326.09064 45.51875 326.4969Q46.12812=
4 326.90314 46.425 327.65314Q46.7375 328.40314 46.7375 329.29376Q46.7375 33=
0.2469 46.39375 331.0125Q46.065624 331.77814 45.409374 332.1844Q44.753124 3=
32.59064 44.034374 332.59064Q43.503124 332.59064 43.08125 332.3719Q42.65937=
4 332.1375 42.39375 331.8094L42.39375 334.84064L41.346874 334.84064ZM42.3 3=
29.3719Q42.3 330.575 42.784374 331.15314Q43.26875 331.71564 43.95625 331.71=
564Q44.659374 331.71564 45.159374 331.1219Q45.659374 330.52814 45.659374 32=
9.27814Q45.659374 328.09064 45.175 327.5125Q44.690624 326.91876 44.003124 3=
26.91876Q43.33125 326.91876 42.815624 327.54376Q42.3 328.16876 42.3 329.371=
9ZM47.95625 329.34064Q47.95625 327.60626 48.909374 326.77814Q49.70625 326.0=
9064 50.8625 326.09064Q52.14375 326.09064 52.95625 326.9344Q53.784374 327.7=
625 53.784374 329.2469Q53.784374 330.45 53.425 331.1375Q53.065624 331.825 5=
2.3625 332.21564Q51.675 332.59064 50.8625 332.59064Q49.565624 332.59064 48.=
753124 331.7625Q47.95625 330.91876 47.95625 329.34064ZM49.034374 329.34064Q=
49.034374 330.52814 49.55 331.1219Q50.08125 331.71564 50.8625 331.71564Q51.=
659374 331.71564 52.175 331.1219Q52.690624 330.52814 52.690624 329.3094Q52.=
690624 328.15314 52.159374 327.5594Q51.64375 326.96564 50.8625 326.96564Q50=
.08125 326.96564 49.55 327.5594Q49.034374 328.1375 49.034374 329.34064ZM55.=
33125 332.45L55.33125 326.23126L56.284374 326.23126L56.284374 327.16876Q56.=
64375 326.5125 56.940624 326.3094Q57.253124 326.09064 57.628124 326.09064Q5=
8.159374 326.09064 58.70625 326.41876L58.346874 327.40314Q57.95625 327.1687=
6 57.58125 327.16876Q57.221874 327.16876 56.940624 327.3875Q56.675 327.5906=
4 56.565624 327.96564Q56.378124 328.52814 56.378124 329.1844L56.378124 332.=
45L55.33125 332.45ZM61.64375 331.5125L61.8 332.4344Q61.346874 332.52814 61.=
003124 332.52814Q60.425 332.52814 60.1125 332.35626Q59.8 332.16876 59.65937=
4 331.8719Q59.534374 331.575 59.534374 330.6219L59.534374 327.04376L58.7687=
5 327.04376L58.76875 326.23126L59.534374 326.23126L59.534374 324.6844L60.58=
125 324.0594L60.58125 326.23126L61.64375 326.23126L61.64375 327.04376L60.58=
125 327.04376L60.58125 330.6844Q60.58125 331.1375 60.628124 331.2625Q60.690=
624 331.3875 60.815624 331.46564Q60.940624 331.54376 61.175 331.54376Q61.36=
25 331.54376 61.64375 331.5125ZM66.59688 330.45L67.69063 330.575Q67.44063 3=
31.52814 66.7375 332.0594Q66.03438 332.59064 64.95625 332.59064Q63.596874 3=
32.59064 62.784374 331.7469Q61.9875 330.90314 61.9875 329.3875Q61.9875 327.=
825 62.8 326.96564Q63.6125 326.09064 64.89375 326.09064Q66.14375 326.09064 =
66.925 326.9344Q67.72188 327.77814 67.72188 329.325Q67.72188 329.41876 67.7=
2188 329.60626L63.08125 329.60626Q63.14375 330.6375 63.659374 331.1844Q64.1=
75 331.71564 64.95625 331.71564Q65.53438 331.71564 65.94063 331.41876Q66.36=
25 331.10626 66.59688 330.45ZM63.14375 328.7469L66.6125 328.7469Q66.55 327.=
95 66.22188 327.5594Q65.70625 326.95 64.90938 326.95Q64.175 326.95 63.675 3=
27.4344Q63.190624 327.91876 63.14375 328.7469ZM73.37813 332.45L73.37813 331=
.66876Q72.78438 332.59064 71.64375 332.59064Q70.89375 332.59064 70.26875 33=
2.1844Q69.64375 331.7625 69.3 331.02814Q68.95625 330.29376 68.95625 329.340=
64Q68.95625 328.41876 69.26875 327.65314Q69.58125 326.8875 70.20625 326.496=
9Q70.83125 326.09064 71.59688 326.09064Q72.15938 326.09064 72.59688 326.325=
Q73.03438 326.5594 73.31563 326.9344L73.31563 323.85626L74.3625 323.85626L7=
4.3625 332.45L73.37813 332.45ZM70.05 329.34064Q70.05 330.54376 70.55 331.13=
75Q71.05 331.71564 71.7375 331.71564Q72.425 331.71564 72.90938 331.15314Q73=
.39375 330.59064 73.39375 329.4344Q73.39375 328.15314 72.89375 327.5594Q72.=
40938 326.96564 71.69063 326.96564Q70.9875 326.96564 70.51875 327.54376Q70.=
05 328.10626 70.05 329.34064Z" fill-rule=3D"nonzero"/><path fill=3D"#9e9e9e=
" d=3D"M19.05 347.1844L20.1125 347.04376Q20.284374 347.9344 20.721874 348.3=
4064Q21.159374 348.73126 21.784374 348.73126Q22.534374 348.73126 23.05 348.=
21564Q23.565624 347.7 23.565624 346.9344Q23.565624 346.21564 23.08125 345.7=
469Q22.6125 345.2625 21.878124 345.2625Q21.58125 345.2625 21.128124 345.387=
5L21.253124 344.45Q21.3625 344.46564 21.425 344.46564Q22.096874 344.46564 2=
2.628124 344.1219Q23.175 343.7625 23.175 343.02814Q23.175 342.45 22.784374 =
342.075Q22.39375 341.6844 21.76875 341.6844Q21.159374 341.6844 20.7375 342.=
075Q20.33125 342.46564 20.221874 343.23126L19.159374 343.04376Q19.346874 34=
1.9969 20.034374 341.41876Q20.721874 340.825 21.7375 340.825Q22.440624 340.=
825 23.034374 341.1375Q23.628124 341.4344 23.940624 341.95Q24.253124 342.46=
564 24.253124 343.0594Q24.253124 343.60626 23.95625 344.075Q23.659374 344.5=
2814 23.08125 344.79376Q23.83125 344.96564 24.253124 345.52814Q24.675 346.0=
75 24.675 346.91876Q24.675 348.04376 23.846874 348.825Q23.034374 349.60626 =
21.784374 349.60626Q20.659374 349.60626 19.909374 348.9344Q19.159374 348.24=
69 19.05 347.1844ZM26.05 347.1844L27.1125 347.04376Q27.284374 347.9344 27.7=
21874 348.34064Q28.159374 348.73126 28.784374 348.73126Q29.534374 348.73126=
 30.05 348.21564Q30.565624 347.7 30.565624 346.9344Q30.565624 346.21564 30.=
08125 345.7469Q29.6125 345.2625 28.878124 345.2625Q28.58125 345.2625 28.128=
124 345.3875L28.253124 344.45Q28.3625 344.46564 28.425 344.46564Q29.096874 =
344.46564 29.628124 344.1219Q30.175 343.7625 30.175 343.02814Q30.175 342.45=
 29.784374 342.075Q29.39375 341.6844 28.76875 341.6844Q28.159374 341.6844 2=
7.7375 342.075Q27.33125 342.46564 27.221874 343.23126L26.159374 343.04376Q2=
6.346874 341.9969 27.034374 341.41876Q27.721874 340.825 28.7375 340.825Q29.=
440624 340.825 30.034374 341.1375Q30.628124 341.4344 30.940624 341.95Q31.25=
3124 342.46564 31.253124 343.0594Q31.253124 343.60626 30.95625 344.075Q30.6=
59374 344.52814 30.08125 344.79376Q30.83125 344.96564 31.253124 345.52814Q3=
1.675 346.075 31.675 346.91876Q31.675 348.04376 30.846874 348.825Q30.034374=
 349.60626 28.784374 349.60626Q27.659374 349.60626 26.909374 348.9344Q26.15=
9374 348.2469 26.05 347.1844ZM33.64375 349.45L33.64375 348.2469L34.846874 3=
48.2469L34.846874 349.45L33.64375 349.45ZM36.05 347.1844L37.1125 347.04376Q=
37.284374 347.9344 37.721874 348.34064Q38.159374 348.73126 38.784374 348.73=
126Q39.534374 348.73126 40.05 348.21564Q40.565624 347.7 40.565624 346.9344Q=
40.565624 346.21564 40.08125 345.7469Q39.6125 345.2625 38.878124 345.2625Q3=
8.58125 345.2625 38.128124 345.3875L38.253124 344.45Q38.3625 344.46564 38.4=
25 344.46564Q39.096874 344.46564 39.628124 344.1219Q40.175 343.7625 40.175 =
343.02814Q40.175 342.45 39.784374 342.075Q39.39375 341.6844 38.76875 341.68=
44Q38.159374 341.6844 37.7375 342.075Q37.33125 342.46564 37.221874 343.2312=
6L36.159374 343.04376Q36.346874 341.9969 37.034374 341.41876Q37.721874 340.=
825 38.7375 340.825Q39.440624 340.825 40.034374 341.1375Q40.628124 341.4344=
 40.940624 341.95Q41.253124 342.46564 41.253124 343.0594Q41.253124 343.6062=
6 40.95625 344.075Q40.659374 344.52814 40.08125 344.79376Q40.83125 344.9656=
4 41.253124 345.52814Q41.675 346.075 41.675 346.91876Q41.675 348.04376 40.8=
46874 348.825Q40.034374 349.60626 38.784374 349.60626Q37.659374 349.60626 3=
6.909374 348.9344Q36.159374 348.2469 36.05 347.1844ZM43.253124 342.91876Q43=
.253124 341.9969 43.70625 341.35626Q44.175 340.71564 45.05 340.71564Q45.862=
5 340.71564 46.39375 341.29376Q46.925 341.8719 46.925 342.98126Q46.925 344.=
075 46.378124 344.66876Q45.846874 345.2469 45.065624 345.2469Q44.284374 345=
.2469 43.76875 344.66876Q43.253124 344.09064 43.253124 342.91876ZM45.08125 =
341.4344Q44.690624 341.4344 44.425 341.77814Q44.175 342.1219 44.175 343.028=
14Q44.175 343.85626 44.425 344.2Q44.690624 344.52814 45.08125 344.52814Q45.=
4875 344.52814 45.7375 344.1844Q46.003124 343.84064 46.003124 342.95Q46.003=
124 342.10626 45.7375 341.77814Q45.471874 341.4344 45.08125 341.4344ZM45.08=
125 349.7625L49.784374 340.71564L50.64375 340.71564L45.95625 349.7625L45.08=
125 349.7625ZM48.8 347.4344Q48.8 346.5125 49.253124 345.8719Q49.721874 345.=
23126 50.6125 345.23126Q51.425 345.23126 51.95625 345.8094Q52.4875 346.3719=
 52.4875 347.4969Q52.4875 348.59064 51.940624 349.1844Q51.409374 349.7625 5=
0.6125 349.7625Q49.846874 349.7625 49.315624 349.1844Q48.8 348.60626 48.8 3=
47.4344ZM50.64375 345.95Q50.2375 345.95 49.971874 346.29376Q49.721874 346.6=
375 49.721874 347.54376Q49.721874 348.35626 49.9875 348.7Q50.253124 349.043=
76 50.64375 349.04376Q51.034374 349.04376 51.3 348.7Q51.565624 348.35626 51=
.565624 347.45Q51.565624 346.6219 51.3 346.29376Q51.034374 345.95 50.64375 =
345.95Z" fill-rule=3D"nonzero"/><path stroke=3D"#757575" stroke-width=3D"1.=
0" stroke-linecap=3D"butt" d=3D"M18.55 336.95L127.05 336.95L276.49954 342.3=
5178" fill-rule=3D"nonzero"/><path fill=3D"#9e9e9e" d=3D"M278.49954 342.351=
78C278.49954 341.24722 277.6041 340.35178 276.49954 340.35178C275.39496 340=
.35178 274.49954 341.24722 274.49954 342.35178C274.49954 343.45636 275.3949=
6 344.35178 276.49954 344.35178C277.6041 344.35178 278.49954 343.45636 278.=
49954 342.35178" fill-rule=3D"nonzero"/><path fill=3D"#1a1a1a" d=3D"M521.34=
064 112.19632L521.34064 103.60257L523.0594 103.60257L525.09064 109.680695Q5=
25.3719 110.54007 525.4969 110.961945Q525.6375 110.493195 525.95 109.586945=
L528.0125 103.60257L529.54376 103.60257L529.54376 112.19632L528.45 112.1963=
2L528.45 105.00882L525.95 112.19632L524.91876 112.19632L522.4344 104.88382L=
522.4344 112.19632L521.34064 112.19632ZM535.3094 111.430695Q534.71564 111.9=
30695 534.16876 112.13382Q533.6375 112.336945 533.0125 112.336945Q531.98126=
 112.336945 531.4344 111.836945Q530.8875 111.336945 530.8875 110.555695Q530=
.8875 110.10257 531.09064 109.72757Q531.29376 109.336945 531.6375 109.11819=
5Q531.98126 108.88382 532.40314 108.774445Q532.7 108.680695 533.34064 108.6=
0257Q534.60626 108.461945 535.21564 108.243195Q535.21564 108.024445 535.215=
64 107.97757Q535.21564 107.32132 534.91876 107.055695Q534.5125 106.711945 5=
33.71564 106.711945Q532.98126 106.711945 532.6219 106.97757Q532.2625 107.22=
757 532.09064 107.88382L531.0594 107.743195Q531.2 107.086945 531.52814 106.=
680695Q531.85626 106.274445 532.46564 106.055695Q533.075 105.836945 533.871=
9 105.836945Q534.66876 105.836945 535.16876 106.024445Q535.66876 106.211945=
 535.90314 106.493195Q536.1375 106.774445 536.23126 107.211945Q536.27814 10=
7.47757 536.27814 108.180695L536.27814 109.586945Q536.27814 111.055695 536.=
34064 111.44632Q536.41876 111.836945 536.6219 112.19632L535.5125 112.19632Q=
535.35626 111.868195 535.3094 111.430695ZM535.21564 109.07132Q534.6375 109.=
305695 533.4969 109.47757Q532.84064 109.57132 532.575 109.69632Q532.3094 10=
9.805695 532.15314 110.024445Q532.0125 110.243195 532.0125 110.524445Q532.0=
125 110.94632 532.325 111.22757Q532.65314 111.50882 533.2625 111.50882Q533.=
8719 111.50882 534.34064 111.243195Q534.825 110.97757 535.04376 110.50882Q5=
35.21564 110.149445 535.21564 109.461945L535.21564 109.07132ZM538.2469 104.=
82132L538.2469 103.60257L539.3094 103.60257L539.3094 104.82132L538.2469 104=
.82132ZM538.2469 112.19632L538.2469 105.97757L539.3094 105.97757L539.3094 1=
12.19632L538.2469 112.19632ZM541.2469 112.19632L541.2469 105.97757L542.1844=
 105.97757L542.1844 106.85257Q542.8719 105.836945 544.16876 105.836945Q544.=
73126 105.836945 545.2 106.04007Q545.6844 106.243195 545.91876 106.57132Q54=
6.15314 106.899445 546.2469 107.336945Q546.29376 107.63382 546.29376 108.36=
8195L546.29376 112.19632L545.2469 112.19632L545.2469 108.41507Q545.2469 107=
.75882 545.1219 107.44632Q544.9969 107.13382 544.6844 106.94632Q544.3719 10=
6.743195 543.95 106.743195Q543.27814 106.743195 542.77814 107.180695Q542.29=
376 107.60257 542.29376 108.79007L542.29376 112.19632L541.2469 112.19632ZM5=
50.54376 111.25882L550.7 112.180695Q550.2469 112.274445 549.90314 112.27444=
5Q549.325 112.274445 549.0125 112.10257Q548.7 111.91507 548.5594 111.618195=
Q548.4344 111.32132 548.4344 110.368195L548.4344 106.79007L547.66876 106.79=
007L547.66876 105.97757L548.4344 105.97757L548.4344 104.430695L549.48126 10=
3.805695L549.48126 105.97757L550.54376 105.97757L550.54376 106.79007L549.48=
126 106.79007L549.48126 110.430695Q549.48126 110.88382 549.52814 111.00882Q=
549.59064 111.13382 549.71564 111.211945Q549.84064 111.29007 550.075 111.29=
007Q550.2625 111.29007 550.54376 111.25882ZM555.3094 111.430695Q554.71564 1=
11.930695 554.16876 112.13382Q553.6375 112.336945 553.0125 112.336945Q551.9=
8126 112.336945 551.4344 111.836945Q550.8875 111.336945 550.8875 110.555695=
Q550.8875 110.10257 551.09064 109.72757Q551.29376 109.336945 551.6375 109.1=
18195Q551.98126 108.88382 552.40314 108.774445Q552.7 108.680695 553.34064 1=
08.60257Q554.60626 108.461945 555.21564 108.243195Q555.21564 108.024445 555=
.21564 107.97757Q555.21564 107.32132 554.91876 107.055695Q554.5125 106.7119=
45 553.71564 106.711945Q552.98126 106.711945 552.6219 106.97757Q552.2625 10=
7.22757 552.09064 107.88382L551.0594 107.743195Q551.2 107.086945 551.52814 =
106.680695Q551.85626 106.274445 552.46564 106.055695Q553.075 105.836945 553=
.8719 105.836945Q554.66876 105.836945 555.16876 106.024445Q555.66876 106.21=
1945 555.90314 106.493195Q556.1375 106.774445 556.23126 107.211945Q556.2781=
4 107.47757 556.27814 108.180695L556.27814 109.586945Q556.27814 111.055695 =
556.34064 111.44632Q556.41876 111.836945 556.6219 112.19632L555.5125 112.19=
632Q555.35626 111.868195 555.3094 111.430695ZM555.21564 109.07132Q554.6375 =
109.305695 553.4969 109.47757Q552.84064 109.57132 552.575 109.69632Q552.309=
4 109.805695 552.15314 110.024445Q552.0125 110.243195 552.0125 110.524445Q5=
52.0125 110.94632 552.325 111.22757Q552.65314 111.50882 553.2625 111.50882Q=
553.8719 111.50882 554.34064 111.243195Q554.825 110.97757 555.04376 110.508=
82Q555.21564 110.149445 555.21564 109.461945L555.21564 109.07132ZM558.2469 =
104.82132L558.2469 103.60257L559.3094 103.60257L559.3094 104.82132L558.2469=
 104.82132ZM558.2469 112.19632L558.2469 105.97757L559.3094 105.97757L559.30=
94 112.19632L558.2469 112.19632ZM561.2469 112.19632L561.2469 105.97757L562.=
1844 105.97757L562.1844 106.85257Q562.8719 105.836945 564.16876 105.836945Q=
564.73126 105.836945 565.2 106.04007Q565.6844 106.243195 565.91876 106.5713=
2Q566.15314 106.899445 566.2469 107.336945Q566.29376 107.63382 566.29376 10=
8.368195L566.29376 112.19632L565.2469 112.19632L565.2469 108.41507Q565.2469=
 107.75882 565.1219 107.44632Q564.9969 107.13382 564.6844 106.94632Q564.371=
9 106.743195 563.95 106.743195Q563.27814 106.743195 562.77814 107.180695Q56=
2.29376 107.60257 562.29376 108.79007L562.29376 112.19632L561.2469 112.1963=
2ZM572.4969 110.19632L573.59064 110.32132Q573.34064 111.274445 572.6375 111=
.805695Q571.9344 112.336945 570.85626 112.336945Q569.4969 112.336945 568.68=
44 111.493195Q567.8875 110.649445 567.8875 109.13382Q567.8875 107.57132 568=
.7 106.711945Q569.5125 105.836945 570.79376 105.836945Q572.04376 105.836945=
 572.825 106.680695Q573.6219 107.524445 573.6219 109.07132Q573.6219 109.165=
07 573.6219 109.35257L568.98126 109.35257Q569.04376 110.38382 569.5594 110.=
930695Q570.075 111.461945 570.85626 111.461945Q571.4344 111.461945 571.8406=
4 111.16507Q572.2625 110.85257 572.4969 110.19632ZM569.04376 108.493195L572=
.5125 108.493195Q572.45 107.69632 572.1219 107.305695Q571.60626 106.69632 5=
70.8094 106.69632Q570.075 106.69632 569.575 107.180695Q569.09064 107.66507 =
569.04376 108.493195ZM579.27814 112.19632L579.27814 111.41507Q578.6844 112.=
336945 577.54376 112.336945Q576.79376 112.336945 576.16876 111.930695Q575.5=
4376 111.50882 575.2 110.774445Q574.85626 110.04007 574.85626 109.086945Q57=
4.85626 108.16507 575.16876 107.399445Q575.48126 106.63382 576.10626 106.24=
3195Q576.73126 105.836945 577.4969 105.836945Q578.0594 105.836945 578.4969 =
106.07132Q578.9344 106.305695 579.21564 106.680695L579.21564 103.60257L580.=
2625 103.60257L580.2625 112.19632L579.27814 112.19632ZM575.95 109.086945Q57=
5.95 110.29007 576.45 110.88382Q576.95 111.461945 577.6375 111.461945Q578.3=
25 111.461945 578.8094 110.899445Q579.29376 110.336945 579.29376 109.180695=
Q579.29376 107.899445 578.79376 107.305695Q578.3094 106.711945 577.59064 10=
6.711945Q576.8875 106.711945 576.41876 107.29007Q575.95 107.85257 575.95 10=
9.086945Z" fill-rule=3D"nonzero"/><path fill=3D"#9e9e9e" d=3D"M546.95 126.9=
30695L548.0125 126.79007Q548.1844 127.680695 548.6219 128.08694Q549.0594 12=
8.47757 549.6844 128.47757Q550.4344 128.47757 550.95 127.961945Q551.46564 1=
27.44632 551.46564 126.680695Q551.46564 125.961945 550.98126 125.493195Q550=
.5125 125.00882 549.77814 125.00882Q549.48126 125.00882 549.02814 125.13382=
L549.15314 124.19632Q549.2625 124.211945 549.325 124.211945Q549.9969 124.21=
1945 550.52814 123.868195Q551.075 123.50882 551.075 122.774445Q551.075 122.=
19632 550.6844 121.82132Q550.29376 121.430695 549.66876 121.430695Q549.0594=
 121.430695 548.6375 121.82132Q548.23126 122.211945 548.1219 122.97757L547.=
0594 122.79007Q547.2469 121.743195 547.9344 121.16507Q548.6219 120.57132 54=
9.6375 120.57132Q550.34064 120.57132 550.9344 120.88382Q551.52814 121.18069=
5 551.84064 121.69632Q552.15314 122.211945 552.15314 122.805695Q552.15314 1=
23.35257 551.85626 123.82132Q551.5594 124.274445 550.98126 124.54007Q551.73=
126 124.711945 552.15314 125.274445Q552.575 125.82132 552.575 126.66507Q552=
.575 127.79007 551.7469 128.57132Q550.9344 129.35257 549.6844 129.35257Q548=
.5594 129.35257 547.8094 128.6807Q547.0594 127.993195 546.95 126.930695ZM55=
3.95 126.94632L555.0594 126.85257Q555.1844 127.66507 555.6219 128.07132Q556=
.075 128.47757 556.71564 128.47757Q557.46564 128.47757 557.9969 127.899445Q=
558.52814 127.32132 558.52814 126.38382Q558.52814 125.47757 558.0125 124.96=
1945Q557.5125 124.430695 556.6844 124.430695Q556.1844 124.430695 555.7625 1=
24.66507Q555.35626 124.899445 555.1219 125.25882L554.1375 125.13382L554.965=
64 120.72757L559.2469 120.72757L559.2469 121.72757L555.8094 121.72757L555.3=
5626 124.04007Q556.1219 123.493195 556.96564 123.493195Q558.09064 123.49319=
5 558.85626 124.274445Q559.6375 125.055695 559.6375 126.29007Q559.6375 127.=
44632 558.96564 128.3057Q558.1375 129.33694 556.71564 129.33694Q555.54376 1=
29.33694 554.79376 128.6807Q554.0594 128.02444 553.95 126.94632ZM561.54376 =
129.19632L561.54376 127.993195L562.7469 127.993195L562.7469 129.19632L561.5=
4376 129.19632ZM564.0125 121.72757L564.0125 120.711945L569.575 120.711945L5=
69.575 121.54007Q568.7625 122.41507 567.95 123.868195Q567.15314 125.305695 =
566.71564 126.836945Q566.3875 127.91507 566.3094 129.19632L565.21564 129.19=
632Q565.23126 128.1807 565.60626 126.743195Q565.9969 125.305695 566.7 123.9=
7757Q567.41876 122.649445 568.23126 121.72757L564.0125 121.72757ZM571.15314=
 122.66507Q571.15314 121.743195 571.60626 121.10257Q572.075 120.461945 572.=
95 120.461945Q573.7625 120.461945 574.29376 121.04007Q574.825 121.618195 57=
4.825 122.72757Q574.825 123.82132 574.27814 124.41507Q573.7469 124.993195 5=
72.96564 124.993195Q572.1844 124.993195 571.66876 124.41507Q571.15314 123.8=
36945 571.15314 122.66507ZM572.98126 121.180695Q572.59064 121.180695 572.32=
5 121.524445Q572.075 121.868195 572.075 122.774445Q572.075 123.60257 572.32=
5 123.94632Q572.59064 124.274445 572.98126 124.274445Q573.3875 124.274445 5=
73.6375 123.930695Q573.90314 123.586945 573.90314 122.69632Q573.90314 121.8=
5257 573.6375 121.524445Q573.3719 121.180695 572.98126 121.180695ZM572.9812=
6 129.50882L577.6844 120.461945L578.54376 120.461945L573.85626 129.50882L57=
2.98126 129.50882ZM576.7 127.180695Q576.7 126.25882 577.15314 125.618195Q57=
7.6219 124.97757 578.5125 124.97757Q579.325 124.97757 579.85626 125.555695Q=
580.3875 126.118195 580.3875 127.243195Q580.3875 128.33694 579.84064 128.93=
07Q579.3094 129.50882 578.5125 129.50882Q577.7469 129.50882 577.21564 128.9=
307Q576.7 128.35257 576.7 127.180695ZM578.54376 125.69632Q578.1375 125.6963=
2 577.8719 126.04007Q577.6219 126.38382 577.6219 127.29007Q577.6219 128.102=
57 577.8875 128.44632Q578.15314 128.79007 578.54376 128.79007Q578.9344 128.=
79007 579.2 128.44632Q579.46564 128.10257 579.46564 127.19632Q579.46564 126=
.368195 579.2 126.04007Q578.9344 125.69632 578.54376 125.69632Z" fill-rule=
=3D"nonzero"/><path stroke=3D"#757575" stroke-width=3D"1.0" stroke-linecap=
=3D"butt" d=3D"M581.45 116.69632L472.95 116.69632L442.9014 116.69632" fill-=
rule=3D"nonzero"/><path fill=3D"#9e9e9e" d=3D"M444.9014 116.69632C444.9014 =
115.59174 444.00595 114.69632 442.9014 114.69632C441.7968 114.69632 440.901=
4 115.59174 440.9014 116.69632C440.9014 117.80089 441.7968 118.69632 442.90=
14 118.69632C444.00595 118.69632 444.9014 117.80089 444.9014 116.69632" fil=
l-rule=3D"nonzero"/></svg>
\ No newline at end of file
--=20
2.47.3


