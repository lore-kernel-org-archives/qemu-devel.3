Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97D6BC369B2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 21:00:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4Qty-0005ut-LA; Mon, 14 Apr 2025 16:59:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1u4Qtp-0005u0-OW
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 16:59:27 -0400
Received: from mail-io1-xd30.google.com ([2607:f8b0:4864:20::d30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1u4Qtn-0003kX-0c
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 16:59:24 -0400
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-86192b6946eso61386439f.1
 for <qemu-devel@nongnu.org>; Mon, 14 Apr 2025 13:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744664361; x=1745269161; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=K4SgLlha3yF8A02kW6QeSYfiFLORMj3pAN9Q7NZjMlU=;
 b=TAyoM3EwYEcCRzp+6MyhmMpO6fm0cBvONa9LiHRYKCZyoHrPT4cbIMk+qWhcssMfoX
 OXANmut33PtgvTrpsm8g/D/9zgq05u4kCFFrxB6SitKDIyrCOf1Uf3+yn8SRbgyI9zyu
 6Iu8EUE/Avo22OVGNujJWkMboxgj6aB1Q0GKtkMghHwcEWrcJqxr2MNY372bE/R7bor6
 qJZm5zBke3JRCZfWvmBsjixQjgD78ry3vHHH7aosoS4a13cvobjKft97AjJ4zdoXieNa
 Nx0h/mNTo355pkEYvKp4b4oiWXae5qlEcMfrA3Wd//EVAVNq/FmqZWKxyzOuoic4TMXn
 Qczg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744664361; x=1745269161;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K4SgLlha3yF8A02kW6QeSYfiFLORMj3pAN9Q7NZjMlU=;
 b=Ht1Pz+EnDbCIcTSnPYOjBsxAh94GLj7nCjObGeW13ESyq8OhQrheIvFN9CQXGVwIiQ
 AcNBWbLegfowImUFwQIwFg6sOMr7xHLHovi3b4WM5s+7COMmFKS5NM24B4A/WAP9v+Kl
 NE4hGl5sWyMvM/80+qzt7/lLOEEHtzibWULvdxAcOj1bnI6U0Odfoppu64OqUla6/8WX
 Zy1iTiPBkplrqUG7W1DdUICJQf0vyWgdtnzywNlmdlMW7QShn4B7cj2/QqN7YEppJsFC
 kRp8R38izukkyRO9KX/IRwQH/5f0RigaPc0LypfZh8Ql9UIJpuGnHj5WJxTbQuwaoDj6
 SvJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPeqvhe5+8wUvSLse1R/DBLhlxj5u5fadKpK6UrS8rdAZUH7luGtu3Ho+nCxLvilIcZwmK5JCxJoTH@nongnu.org
X-Gm-Message-State: AOJu0YxPMmCU70SyECL4GrFyk4+n/fM5rvN1wpW4cNfSpEmhWO/CoSts
 gk0XJ6VLOvg5UHwmoYPRZhOymyP3fNfn5+pcEe28SjNGQa70hjfs
X-Gm-Gg: ASbGncsBl3lrIi/rbkTBRVVP78/bTidEz6+hN3UvwMh1T2bqsLJhSxRq9v3nDAqK50Z
 MGkYq0U4RdAcgcwc0YyuWtd0629ZpmAaqnyoCgsiGsTNG/9lhIn2Ts7WLGiqvYq0padnHMu/LHs
 mJLhZv89NzkI0N4so/16i56EQcP2ZxkMtZWyHW2ge/B2iQghgGuRagqgCtTitjC94z5jjfCcc6b
 /hT0KqehF9s4afGTnu9tTeqrvfz2atP+HdQsZt5f1wcIHaOMDHQYRhp1nTa/crIlIK25GBVJ9or
 TBcD23enQdF5yAhVhUmRNV2zARU/fP2JFkUKlCx4iijN5J0dXzpcxjdfYQR3RIKXb3c6FpUONNs
 =
X-Google-Smtp-Source: AGHT+IHILdE67KVd8todqNQyw3e+ZS6y6YvFumKhE933oKODDayl74t1MCxos/jpdGQnv5ir3g7jRw==
X-Received: by 2002:a05:6e02:1a6b:b0:3d3:eeec:89f3 with SMTP id
 e9e14a558f8ab-3d7ec219605mr110472575ab.13.1744664361298; 
 Mon, 14 Apr 2025 13:59:21 -0700 (PDT)
Received: from DESKTOPUU50BPD (c-67-190-160-7.hsd1.co.comcast.net.
 [67.190.160.7]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f505d3b9fbsm2760628173.73.2025.04.14.13.59.20
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 14 Apr 2025 13:59:20 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Matheus Tavares Bernardino'" <matheus.bernardino@oss.qualcomm.com>
Cc: <brian.cain@oss.qualcomm.com>, <qemu-devel@nongnu.org>,
 <richard.henderson@linaro.org>, <philmd@linaro.org>, <ale@rev.ng>,
 <anjo@rev.ng>, <marco.liebel@oss.qualcomm.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>
References: <058801dbad61_68ff5b00_3afe1100_@gmail.com>
 <20250414180939.3575845-1-matheus.bernardino@oss.qualcomm.com>
In-Reply-To: <20250414180939.3575845-1-matheus.bernardino@oss.qualcomm.com>
Subject: RE: [PATCH v3 5/5] target/hexagon: Remove unreachable
Date: Mon, 14 Apr 2025 14:59:17 -0600
Message-ID: <05df01dbad80$17e73890$47b5a9b0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQENfVRWeNfVsGY4Eunk52BzijBbDgFBXIfstTX6CNA=
Content-Language: en-us
X-Antivirus: Norton (VPS 250414-0, 4/13/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::d30;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-io1-xd30.google.com
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



> -----Original Message-----
> From: Matheus Tavares Bernardino
> <matheus.bernardino@oss.qualcomm.com>
> Sent: Monday, April 14, 2025 12:10 PM
> To: ltaylorsimpson@gmail.com
> Cc: brian.cain@oss.qualcomm.com; qemu-devel@nongnu.org;
> richard.henderson@linaro.org; philmd@linaro.org;
> matheus.bernardino@oss.qualcomm.com; ale@rev.ng; anjo@rev.ng;
> marco.liebel@oss.qualcomm.com; alex.bennee@linaro.org;
> quic_mburton@quicinc.com; sidneym@quicinc.com
> Subject: RE: [PATCH v3 5/5] target/hexagon: Remove unreachable
> 
> On Mon, 14 Apr 2025 11:19:38 -0600 <ltaylorsimpson@gmail.com> wrote:
> >
> > > -----Original Message-----
> > > From: Brian Cain <brian.cain@oss.qualcomm.com>
> > > Sent: Monday, April 7, 2025 1:27 PM
> > > To: qemu-devel@nongnu.org
> > > Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> > > philmd@linaro.org; matheus.bernardino@oss.qualcomm.com;
> ale@rev.ng;
> > > anjo@rev.ng; marco.liebel@oss.qualcomm.com;
> > > ltaylorsimpson@gmail.com; alex.bennee@linaro.org;
> > > quic_mburton@quicinc.com; sidneym@quicinc.com
> > > Subject: [PATCH v3 5/5] target/hexagon: Remove unreachable
> > >
> > > We should raise an exception in the event that we encounter a packet
> > > that can't be correctly decoded, not fault.
> > >
> > > Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> > > ---
> > >  target/hexagon/decode.c | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/target/hexagon/decode.c b/target/hexagon/decode.c index
> > > b5ece60450..1db7f1950f 100644
> > > --- a/target/hexagon/decode.c
> > > +++ b/target/hexagon/decode.c
> > > @@ -489,7 +489,6 @@ decode_insns(DisasContext *ctx, Insn *insn,
> > > uint32_t
> > > encoding)
> > >              insn->iclass = iclass_bits(encoding);
> > >              return 1;
> > >          }
> > > -        g_assert_not_reached();
> > >      } else {
> > >          uint32_t iclass = get_duplex_iclass(encoding);
> > >          unsigned int slot0_subinsn = get_slot0_subinsn(encoding);
> > > @@ -512,6
> > > +511,11 @@ decode_insns(DisasContext *ctx, Insn *insn, uint32_t
> > > +encoding)
> > >          }
> > >          g_assert_not_reached();
> >
> > Why leave this one rather than raising an exception?
> 
> Good point. I think this one should be removed as well. We have removed it
> downstream already.
> 
> > >      }
> > > +    /*
> > > +     * invalid/unrecognized opcode; return 1 and let gen_insn() raise
an
> > > +     * exception when it sees this empty insn.
> > > +     */
> > > +    return 1;
> >
> > You should set insn->generate to NULL if you want to guarantee that
> > gen_insn will raise an exception.
> 
> The caller already memset's it to 0 before passing `insn` down.
> 
> > Do you have a test case for this?
> 
> We do have a softmmu test for this downstream. Maybe we can adjust it for
> user-mode and upstream it with this patch.

Take a look at tests/tcg/hexagon/invalid-slots.c to see how to do this in
linux-user mode.  You'll also need to modify Makefile.target in that
directory.

HTH,
Taylor



