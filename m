Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 044C9C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 10:44:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh3HU-00066a-3B; Tue, 07 Jul 2026 06:44:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wh3HS-000668-EZ
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 06:43:58 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wh3HQ-000485-SF
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 06:43:58 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-6611669cd16so5569477d50.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 03:43:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783421035; cv=none;
 d=google.com; s=arc-20260327;
 b=eqBKjAp01tvpn4hxF+lSGlhVt8zUyf1NKS907x43rsSc+fnRd518y0UuApLFwdvosp
 AJ4lPMbSL99Ni2gSEhJOQy3P62Bz82ovjwX0Xy4KFCL10o1dckUN3y0SPgAMAFahmDAY
 /0VBu/9Nm4HKz8r7tWkaMiPpOwm06RggXshZU3AlNuQWcktQf0fTZmWFX1PbfJcfRDjl
 CQ27ssZDt2+fVNweRt2vLyijfWAIGeMMrnNCMtQmJzbS3IgqRvJIisvz6Llgfk6/nWD+
 RETv8wP9ak+oGsz652dXDcrtvcCfodZv4nYN8gnp9mrdQS/HiN/ByQEquVgi6mGhTuVF
 GGdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=a4Za2vOUCu9/1r75AG6k691yxycMkdWuYMeptLr85R8=;
 fh=oF6yPMT/3eJ4kfb0aBzaMPpIr+MB4kS4kk98rDLBTM4=;
 b=I7oDDI2zQjnweewf0CPko1T1bY6ezxrgyMwNJ58EmcNOVHcL7LNIkpEJG2Cf7mq2Jb
 +Ke6RWMHxIm5Kxu+HIbwsg0OAbZ7IzHVhbskFLDVtAep6bi0f8rznJO6+K7C9FLw1GC9
 cNbkZ4Jj98vyXioG93hbx/dRREecLfWqXIadYPUlAIlTInoq1hqCA5y+aQnfwxvcbRVY
 Xmrsilpr+n/3Xq4oq6ZULWk1myFzpGOeZUo+rWb8ky5uHD4Yvge3eB9qC4Tp3sie9vs8
 B3sq+P7RKQEZ/hj+IeCYMkC5SMCrqQU4Yph9kdQIXPX0QoVfe3yZ4iG+AxncOL9qr8L4
 sz2A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783421035; x=1784025835; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=a4Za2vOUCu9/1r75AG6k691yxycMkdWuYMeptLr85R8=;
 b=K96O6y85ackUjJVBCU6DQd89tZf3ihfGUPJfYiPYkbS7RIgY88oL8ibW0O3i/EQlX7
 h5QQi2uc8APDtIqVRbwflUe7c0hXqU7uNHyK7gAGkuSQvy90gBFGLig960KgLIHxmNkY
 ePNdwkanPzZ6y5K3vWrW0q8lldXOIRiEH3blBfvl5NdbPKwuz6h3y4WmC2JuwUV22B2R
 3su0k7heqwARBIwmxFs3CbEqSzAo4K4kjMktfL7zExqiQWusApMTX8kAY6hh/H5rHOnE
 17Px/UYP+6sUJA9wBtLp1JNe+tu1eyAcW1/wCOx9xy8KEIuf4zt0PYEOLoeKb5EAQ9xi
 rLzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783421035; x=1784025835;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=a4Za2vOUCu9/1r75AG6k691yxycMkdWuYMeptLr85R8=;
 b=a4Xhv0fhI6W/tG0UKiq9aAIZItnx3cLfZAlRtxWfP5YDxMn7606ZJ95A8rB3f/ASDE
 9sFgOoVHE6/9ccZbr7TGOxEXXdXui39LE0lJ0w+HV4uvn6KiQdfj8eNJpg7BvMvDPWqG
 JohWRhPG/GF1+hhY+ZUxPdz8wEKKKKJGyWJN6YcnHCQvrHRaEp3FiVkFl59YdCQGe1FF
 UJ7+MjjETvYpsBezfIRAo+V0okzqXGnocAMZFrjIbAi09lpWCpDp6v90lIRbYpFVC/n1
 Onk4om0VLsl8c4oVl7p4fLbo5NhW0TQ9UJ4A39XXv0JDhnd5HEelkngipELwkUswsI/Z
 rYjg==
X-Gm-Message-State: AOJu0Yx4xj+U0nB2MM7T+7BG4KtT7OTCfjkZkNOl2q5KfdTLVEv+3GMP
 bdR0sH9kU2mHGUBq6ZIejvvCheWZ0cnCLMgFbjz9jJIL4vKXveMwxkqwJ90IWhYve+XEnL47NLb
 0Q++zf1huv8/KmmV8NOveCF6zBbsXOQV5pbdWbv8erg==
X-Gm-Gg: AfdE7cmQjYnbVAbaz1u8E3LgvQ4Yxt47GwKOsXHQgyt2hrbYTNDwkypE9SWQ382I9nm
 bz/PYJtkKcKR5HQ5DlenM9791kT4cc4clnexrmQ6cTppDRvzE8//0j41uhUbub8zMrgIhLP4mdd
 lkj4K2rJR0UeY9kGp6TKp50YjakUM5ipVbLH1gQlS5FoYoOjHOJR7hdw5QdJ4iPqUO7ef9atf4o
 7PzQQIXSfNPts0tt1KvOrIaWvfA1ab3R9hf/o21AOGrMfyPTvqOjjwo+tn/aSkyWig/kQNPgwUv
 Dx9CZCfZGJaqrPg2g+h3JJ3CbOH/wSfDPkPV5Z39wwk+2hGVofoWoQ51
X-Received: by 2002:a05:690e:4386:b0:667:6034:d273 with SMTP id
 956f58d0204a3-6677faedbb4mr2670410d50.5.1783421035511; Tue, 07 Jul 2026
 03:43:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260702184038.178196-1-shentey@gmail.com>
 <519f6e43-5273-4426-b673-71cff44daffa@oss.qualcomm.com>
In-Reply-To: <519f6e43-5273-4426-b673-71cff44daffa@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Jul 2026 11:43:43 +0100
X-Gm-Features: AVVi8CehRy-VKWeD7SVF3oAyi4pbiJkeSstNGWL2B8a6GGaZpHUITZLEXLddr50
Message-ID: <CAFEAcA8aR6GPZWDphbTgPhVf3G=eoNrAFdb9QcLCGh9hdavkAA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] hw/arm/fsl-imx8mp: Add inital FlexCAN support
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Bernhard Beschow <shentey@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org, 
 Matyas Bobek <matyas.bobek@gmail.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>, 
 Gaurav Sharma <gaurav.sharma_7@nxp.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, 
 Jason Wang <jasowang@redhat.com>, Jean-Christophe Dubois <jcd@tribudubois.net>,
 Francisco Iglesias <francisco.iglesias@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Mon, 6 Jul 2026 at 14:25, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 2/7/26 20:40, Bernhard Beschow wrote:
> > Now that FlexCAN emulation has landed in master, let's add it to imx8mp=
-evk as
> > well. While the real i.MX8M Plus supports CAN FD which isn't emulated y=
et, the
> > non-FD mode works well under Linux: It is possible to use `cangen` and =
`candump`
> > either way on the host and on the guest, as described in
> > docs/system/devices/can.rst.
> >
> > This series consists of five patches where the first four are preparati=
ons.
> > The last patch integrates FlexCAN into the i.MX8M Plus SoC and EVK boar=
d. The
> > first preparation addresses the review comment from [1], and could be a=
pplied
> > independently.
> >
> > It would be nice if this series could make it into 11.1.
> >
> > Testing done:
> > * Start imx8mp-evk and run `cangen can0` there. Observe on the host tha=
t
> > `candump vcan0` prints the traffic.
> > * `make check`
> >
> > v2:
> > Thanks for the very helpful and super quick review, Phil! Here we go:
> > * Add patch "hw/net/can/flexcan: Wire clock control module via link pro=
perty"
> > * Have separate MemoryRegionOps for 32 and 64 bit
> >
> > [1] https://lore.kernel.org/qemu-devel/77d5891c-de12-467e-8746-02fe4312=
1e3e@oss.qualcomm.com/
> > ---
> > base-commit: a59157f98f0b69b0bbdb26bc15fbc4d6c8060799
> >
> > Bernhard Beschow (5):
> >    hw/net/can/flexcan: Wire clock control module via link property
> >    hw/net/can/flexcan: Subclass TYPE_CAN_FLEXCAN
> >    hw/arm/imx8mp-evk: Open code DEFINE_MACHINE_AARCH64
> >    hw/arm/imx8mp-evk: Introduce FslImx8mpEvkState
> >    hw/arm: Add basic FlexCAN3 support to TYPE_FSL_IMX8MP and imx8mp-evk
>
> Peter, you just sent your (IIUC) last target-arm PR. I'm about
> to post my hw-misc one, do you mind if you take this series which
> is fully reviewed/tested?

As you note, I've already sent the last target-arm PR for pre-freeze
yesterday; I'm not going to do another one. So from my POV this
has just missed the deadline and will have to wait for 11.2.

thanks
-- PMM

