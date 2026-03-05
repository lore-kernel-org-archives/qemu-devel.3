Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB4BF47CA3
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 17:48:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyCnA-0001tD-Oe; Thu, 05 Mar 2026 12:47:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyCn9-0001s6-5z
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:47:19 -0500
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyCn7-00023P-LS
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:47:18 -0500
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-798578e2918so78353727b3.2
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 09:47:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772732836; cv=none;
 d=google.com; s=arc-20240605;
 b=VRQAGaOshwy5fW1SkocQY/vcdQBDH7lO7GSONsyAlJyp51xxfMq6sySGMmuHBwXK69
 RrIU2QscI8v3o1mYY0we5Gm4oVFlMuomdnBvixx52GbwapRsmFqqkDlb5Gv9L8qKKy/5
 59T7mopRzt8J5w+xpHon0nZbSPRiLI5bN6VSHLxZO5oB8h0UfHGn2TLPDFXK3pWUZWAE
 7GEMi4yMyzokrnlv6hZw6TDRzXLaY1TaDab3RIqGEj85JzrKjxXfCv1jgr7g1r5Pw9zp
 SfyDlbtaEi9rURDpHd10POdRA6i9BC1wvsZw/amst358si29DoJh2QuOzHhApzvhYcBF
 oEKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=VzOEpTifqDe8W8XBQgO9RHZD40wqT/qXX2JvoFIqRnU=;
 fh=HEYKxdnOCHCEn5FRF+hHHVM86rDkVhD0oqRuWk6Tuys=;
 b=lGW6eNUOhErkaCyJoVxVyIFElTl9fEbYCdSe7GpmKccZ3aSNm95aGavDm3ICjOGd0a
 MhVKEiiP2nKCSugm4MppAzlVx3SlIGwksbHfm6oGVjTpTMFamfVCCZ+QnGxzkCiyMH0K
 bFjV0TWsSanOEzy6r8EIt59cFbJp7SLYA+mecw2GVsE7oE64/9xW2C2H82zs7Xagjvzm
 CM+FDTLMZ67hQ/5hKsO2b2Pr+1uWqk+xgUZ8gNknK1te0E4HrjbC+8hCxgP8LjGyazwc
 TwhWvYkMyejAjVDK9RL1wY878vOTra++kzGYyBBRz8ZmLKs+GXcas2/3Uz0+RPhbTffD
 oNpw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772732836; x=1773337636; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=VzOEpTifqDe8W8XBQgO9RHZD40wqT/qXX2JvoFIqRnU=;
 b=xDW7QvnbkFB2IycdWzc/kwO6csS+7Huv73mvgH7Z5dyY3mWDYhERMxzptX4rSR2be4
 U2+jiZAhyz8hEoSf0cu3pMOteaPVKABng8fCaVNFs3OTZd2gPHjcrgF5haAZRvbwHJx8
 8ErDPbqgQ0FmQUNZqusvfJhYfxC1YQNHqgsaFGpxEqdTGawLKjp9BOA7m+rhBidvkzpl
 3o58bfg/TPnsYyVdf32ixGfFgmSw2k8EEzZHKM6lLgVDoTX0NUgjjD1l/L1xt1pF4IpG
 ouPSS1okX2oCJ8lN/vG45P7ynmUGczuCAjmC4SFhBIITZGRVGJFZ2k3JvB+2cn34/Fxa
 oQdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772732836; x=1773337636;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VzOEpTifqDe8W8XBQgO9RHZD40wqT/qXX2JvoFIqRnU=;
 b=Zrp2E4Wtp6N1jBsuQHX3MAeGJvBNYmjFR2rS669KUsitSU9gXMJepCFlqwqXKA58Xv
 Rkcvzt3iLPh0bp5cCp29eWJZX8q0OF12LJp8uwOmQ0Dd3TqgbCrqz9J6ISZmb49uuISn
 btZDboyjhGbh6wcY2D/p6Cull+pQ3rEFA0c4DyGur6b4HS9K1lmIV+AeQhRxVbmxp83k
 XVWSmvB8qPzPoAP38byqGHVFi6hxcfqeum6RO9bGOy3xrUB4NlUbvTBlgp3Ln9/wY9kW
 uObqpc+/pm4bpGbHt2csVhDi2/LWeu3kEY/FbYywX7JGRNA8e3JwElnYP82hCd881NIX
 5WsA==
X-Gm-Message-State: AOJu0YxzorLPS7Sw11+ecNSQ3lnY2wTs2OJCtuGI5io+zGzyhAa/EEA/
 BwFdMOR9U3dFR8meFuNDqR1eK/s0yMJ7NROR8wMc+isqtMefFGS9/oQi+XW/2/+XtpBd/ElovSk
 7KRnZeeoQiJGb+gKwQUVL+AAsHiyNg/QpzRH+D+WkIiwGoHmyMnzhxwk=
X-Gm-Gg: ATEYQzxP2r0kw14KGJGTYqPnlP41Fv6sMDJQ7WlFmEPgjSXnAP/9UjwZGya2KuLWFKV
 ZjZ6Yb0lCshXJJDrUNHYYKUMBDDz1Nhx6AsxJMqtD4q/QZmHFbTSVduBalCtb+JnYDbMmypOCbY
 sUen8tsluot9jtqhnzbXz2KvlEd/O4ZR5kSdLdEcIiPKOS41zHHhNtd7aGY34LBh12zDPfMQsy/
 1GjsgZ5Qn5Ua8zBT5CcVHVNmxevUqFBYeCKcjojLYhKc7ye9trOv9OZCw0BBcwt4JO7/G/6nmd5
 0ze2WOItc6w19I4i0/5av+1sDS/vLJFjpzRWIIc6WuVjG7lf2dNwEXEN7DIMCdbiwn7j8jEXCDR
 qjg==
X-Received: by 2002:a53:b191:0:b0:64c:b7c9:dffd with SMTP id
 956f58d0204a3-64cf9bb00ccmr4188790d50.58.1772732836096; Thu, 05 Mar 2026
 09:47:16 -0800 (PST)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Mar 2026 17:47:04 +0000
X-Gm-Features: AaiRm50SbtMPHOsZcmh9-SXSrbn2zVW9NUgnpSWn8X06ZsO2AaonCwRuRXSeddY
Message-ID: <CAFEAcA9QAyZjjj4kXeC+wM4gg_C+U6Z7McYGrB9u=C1PbiaWZw@mail.gmail.com>
Subject: duplicating CPUs with memcpy() in cpu_copy() vs memory-allocated
 things in CPUArchState structs
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Laurent Vivier <Laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

In the user-only emulators we need to be able to create a new CPU
object for a newly created thread that has the same state as the
one in the parent thread. We currently do that in cpu_copy()
in linux-user/main.c, which does:

    CPUState *cpu = env_cpu(env);
    CPUState *new_cpu = cpu_create(cpu_type);
    CPUArchState *new_env = cpu_env(new_cpu);

    /* Reset non arch specific state */
    cpu_reset(new_cpu);

    memcpy(new_env, env, sizeof(CPUArchState));

plus some special casing for things in the CPUState (cflags,
and breakpoints), and an ifdef for x86.

This makes several assumptions:

(1) nothing in a target's CPU struct is runtime state that needs
to be copied across from the old thread's CPU
(2) everything in a target's CPU env struct can be handled by
a shallow memcpy() from the old to the new

Unfortunately (2) isn't true. The example I ran into was
MIPS, which allocates a data structure pointed to by env->mvp.
Copying the pointer from the old CPU means we leak the structure
the new CPU allocated on creation. (We don't actually try to free
this at the moment, but if we did try to free it we'd do a double
free because both CPUs would be pointing to the same thing.)
It seems likely that there are others too.

(1) seems on somewhat shaky ground too, especially as we don't
document it.

There are a couple of ways I can see that we could try to fix this:

(A) We could insist that every target's CPUFooState (env struct)
must be shallow-copiable, and anything that isn't (pointers, etc)
needs to be moved out to its FOOCPU (QOM CPU object struct).
Then we could let targets implement any per-target copying specifics
in some function in linux-user/$ARCH/ that we call from cpu_copy()
after doing the memcpy(). This would be painful if there are any
targets that have something non shallow-copiable that they want
access to directly from generated code, which has the env pointer
but not the CPU object struct.

(B) We could standardize the "end_reset_fields" convention that
some targets have in their env struct, where an empty struct
marks the end of the point in the struct where fields can be
reset by zeroing them. If they can be reset by zeroing they can
also be safely shallow copied with memcpy(). We could then let the
target handle anything else via some target hook as above.
This would require a lot of targets having this field marker added,
which could be a pain if they don't have their structs ordered in
a convenient way for this.

(C) We could say that trying to write generic code that can
copy a target-specific structure is a fool's errand, and require
the targets to implement it entirely themselves (only copying the
stuff in the common CPU base class in common code). If a plain
memcpy() works for them then their implementation can be simple.

Any preferences ?

thanks
-- PMM

