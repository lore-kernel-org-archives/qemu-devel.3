Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0161DCCFA00
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 09:55:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGDlJ-00061m-65; Tue, 04 Nov 2025 04:55:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vGDlH-00060S-Tn
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 04:55:35 -0500
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vGDlF-00037n-LY
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 04:55:35 -0500
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-63f74b43db8so5469719d50.3
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 01:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762250131; x=1762854931; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SQVgsFdQYmlGc1Uvi2z+STb+c6e4INSIakBM4JuAZEQ=;
 b=ppWsH+UJcHhHJiEimjgjdc8hiFn9T/8ilFY6GuDZZcTE+Tt/dzY9zsgtfVJcHgs2Mv
 mS7G2UhsCmqL8fdT6N9ZPniIRxB/hfrXMi6gDu8VqVO6823urC6FqzqiDFSsiwrq3Jcd
 cGq358GO0sqJDSZA5DqC+p0ScfijyCJoI9vlixG94qxscV9Wc8OBsOHb3xMIi38x1KH0
 r1SzXAWbmn1qXgXVbaCvPVbh9axSn6Q0ClL9s5px4J8oKxnaJj/HvaUPXDy7KoIHnQBM
 LIo9bXUCFKjDTYlDd1zRntCn9Ou4dBw3QR22r4RbHAKgqZ4Y878rz3GwhhYSuRyoF40V
 MOkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762250131; x=1762854931;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SQVgsFdQYmlGc1Uvi2z+STb+c6e4INSIakBM4JuAZEQ=;
 b=BOycg8f0rT4zOTg05R8NhVEZPXnfJL++XPELF5ADmPen9WI0dzE3kygrRJYxiYuZb9
 PstganM7T0vzKhM1A6fc6hkWmJzMRQWyoQu4wFjLKnv/IOpRMyumveAlzUFtpF9IclRO
 6rRXZBAvanPVZhaUtSpzxCWK4nSZkwtsUZzjRa+K2Yn20IGI9a8OZk0DfcYMKJxUY8cF
 ohxRVmY9Syr6+kX+zNSky1QT2xY1ix/dHBWGTILgd0OZPhkKYJWPFr7qKpsiQ7UPhP6P
 JIH0aL8WWIYakcwpb9pFpAE7kQZrGXMesd3N526Sg2TwNWYQLrN5WMIphXy+ehUi4XtM
 TnCg==
X-Gm-Message-State: AOJu0YwZsoFvHbGSKBAp9Tfi4ziqdIAh0u3I41yvCZrrXh2qXC2WWjdY
 Vz2r/6+xMOEGrmaMjWJJq3I4Et/DN9SFo1wNOlyAOGzNL0yFFEPFqq3vdr1fJE603ruYxhsSoo1
 Xo7fNOCN4yNIVY5VVzDIgfP8BQPe2RRjqQ5FhHBqMig==
X-Gm-Gg: ASbGnctzD1yHjERW/UN5Y3o9e3W208Y4Whp7hNi4wH7gUzu4eLgoFHRRC4G44xwL8oS
 XEvXD/BUSBN9OPRSTZBi+r8U+UmKMKZRYK63W9YlJfcZDOPEm4kUQ8lLf9ule0OnvbsA1AeyEYV
 nH+2vY/Hm9ojt/AVUGL6TS/FKeuxgtVJkapuIDRXBYWoHeLUijzcwLaW5LtAh7RQCovZXvXJsqJ
 B8NnTxw+DLaejV23pkAPCicdStkqn8tPyl0YuVDjqUb7pEc46ZUAb1Icz/UEw==
X-Google-Smtp-Source: AGHT+IEORz7Qjt7+dIHFsrN4GIyP5C6FUqwfaHobCr3CEpVmDMO0VPeoRgfJawx+z6vMlCrMfEX6eYdzxkRYh8dkGc0=
X-Received: by 2002:a05:690e:c4d:b0:63b:8e09:7a47 with SMTP id
 956f58d0204a3-63f9224ecdemr12010660d50.19.1762250131626; Tue, 04 Nov 2025
 01:55:31 -0800 (PST)
MIME-Version: 1.0
References: <20251103175851.428816-1-peter.maydell@linaro.org>
 <20251103175851.428816-2-peter.maydell@linaro.org>
 <43eda65c-be7a-4e3d-86ba-89d2e8af91d6@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <43eda65c-be7a-4e3d-86ba-89d2e8af91d6@rsg.ci.i.u-tokyo.ac.jp>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Nov 2025 09:55:19 +0000
X-Gm-Features: AWmQ_bkf5NcpnaIsXArmDQwylaHr4J4KP-n2usbaLQZNpIEID8h_GtNf_cxgG7M
Message-ID: <CAFEAcA_0+_OegEdqUiti+4YGe__ZjCYONduZ4jGhDoLykrirRA@mail.gmail.com>
Subject: Re: [PATCH 1/3] hw/net/e1000e_core: Don't advance desc_offset for
 NULL buffer RX descriptors
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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

On Tue, 4 Nov 2025 at 06:11, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> On 2025/11/04 2:58, Peter Maydell wrote:
> > In e1000e_write_packet_to_guest() we don't write data for RX descriptors
> > where the buffer address is NULL (as required by the i82574 datasheet
> > section 7.1.7.2). However, when we do this we still update desc_offset
> > by the amount of data we would have written to the RX descriptor if
> > it had a valid buffer pointer, resulting in our dropping that data
> > entirely. The data sheet is not 100% clear on the subject, but this
> > seems unlikely to be the correct behaviour.
> >
> > Rearrange the null-descriptor logic so that we don't treat these
> > do-nothing descriptors as if we'd really written the data.
>
> Please make a corresponding change for igb too so that the code of these
> two devices will not diverge further.

The igb_core.c version of this function seems to be
rather different (and rather easier to read). It has a
kind of related bug where igb_write_packet_to_guest()
calls igb_write_to_rx_buffers() and assumes that that
function has correctly set pdma_st.desc_size to the
amount of data written to that descriptor, but the
early-return cases from igb_write_to_rx_buffers()
don't actually update that field so it will be whatever
junk was present from the previous iteration.

So it looks to me like there are similar bugs but the
code in these two devices is already pretty different
and the fixes don't transpose one-to-one. (For instance,
the problem with the assert location fixed in patch 3
here doesn't seem to be present in igb, which already
does the assert() at the top of its loop in
igb_write_payload_frag_to_rx_buffers().)

In any case, I don't think it makes sense to look at
fixing igb before this patchset has been reviewed
and we're confident the fixes are actually right :-)

thanks
-- PMM

