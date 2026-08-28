Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17486C61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 08:25:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzruC-0007MG-R2; Fri, 28 Aug 2026 04:25:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scherer.simon89@gmail.com>)
 id 1wzruB-0007M6-Mi
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 04:25:43 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scherer.simon89@gmail.com>)
 id 1wzruA-0005Sz-Cs
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 04:25:43 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-66d2b3092c1so1270944d50.3
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 01:25:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787905541; cv=none;
 d=google.com; s=arc-20260327;
 b=cp/cu+Ltl4DBDLLC84CGa/df6/IIfoQsxs7ZPg8TtgshsJc5fDaducKdz+jT+zNMpH
 GRmoCvJb7dLd4geUSdqC9gwEWfhNwIf1+YE7AZ5dptN5KJwjIuWLDFBHWn5MjWnyPiYK
 EgPdTq7y4mC7/Hs+bDeP5oC61W6LTVoUmJF8A8lnnzql2j7TIg3EmK0J68xYfCMOwwW5
 7/ul2p+gih2quqZBNv5ycOFgD0b8wAZ62EYGqnr7LEmfp63vn4DwU105gfLoOuYSEtd9
 aNd68PklMEba3cfCqQDJBHd924vZ7ILHf1uq3NI9wQXjT3me+4AJXUfmKZcdPeHUQTiu
 Bs3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=tWpCDoiD9NMKCEszHA/+YLIRDNlxeJTs8EYMY1ya9ZU=;
 fh=TzfskRGa/6C5EpqINbGNdUAjd9sbShQ0gR80QPWZhUo=;
 b=VASGWhqrEaBSe8DqxsYafNe7KmILUSpJ6a4IuwvSOWHGSNofpm7yN6TxpnWNNwPxyl
 x+GfxPbXfz+/yyLrLHejwCWsAiT76uTJwe6dII5kUYsZ5w2e2OvXCUvrupsUy14Va/a6
 Nns0y5cF/vPtJutELORSY2XBikpsLBipgbidNAnaClTZOU/7DCBwXFo9jPXSqGaAVcF0
 j42HCVWibSADJf+Sfml4ZIBIlg7ErAmB+Xf36LOQxJ4HyTNdvTsS45FBUiD0ZkRz83qI
 qzFoLIRAbYWMzGhJOrgNWzhP/ixUAQtdHCB2Raw8ukOJGyW2DvtLCeOeByoCBs1ic2Gr
 9Diw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787905541; x=1788510341; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tWpCDoiD9NMKCEszHA/+YLIRDNlxeJTs8EYMY1ya9ZU=;
 b=lmeXw8MfSRkTzcixxIV+4FFivV00hRMa8XEgUD9qoDtgy4sfo+heC8Pxk/EuzBjieX
 8SnooQnYJjiYCDmDtfQ2MCS6UqJ1Rj2tnCvWF7qbB/zi59mfLCzbJmyABiUOvqbl8d5y
 9tBN/f3aW7CnQi+U4L9B6DT2tYhsFnSp7qnLUggcaApLXVhYJ56uXWWPeD9UAUcNdSyY
 6AtwYltxw7qL1lZQiHyfwfjA6ZNZnhuz/B3LwHMChFdmtNvn9AMloO5GOszIhv4aQBYh
 Zdaoz2BKW4SsXTsBr3KyBZZkrQiIV13rvKl9k510aGBaWMq/PAiL9ZdChHqQ5IGz4PbH
 r8kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787905541; x=1788510341;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tWpCDoiD9NMKCEszHA/+YLIRDNlxeJTs8EYMY1ya9ZU=;
 b=Lf8ItpwhuTRErO/VjAhicCLHyDVcahU7QSIoUF3qKSr+6qZhCXWRwaiezjQ5jCPGe/
 vCVcLwtYJlSZkbd9XRs0ywh4DHM3qBX/dl72CopFY0qT5rsq0UBwXRcAbrJvfK5yspTt
 jB7Kf494tzaxWOVGbX5+ghpPhaF/+w+CSkMqM6adtvB6DmLpQi/CT04IcKRrBt0T/f4e
 7SipfgRkJMpEHOUPmZVrG/DEGEYtg72Cy+Jf41N7ufYJPitS/yxB7NeXNOg5yeuRzQBo
 BNqaeaPIge3+3CDjhXoIF1vt090EfFUd/iqDPFAHMioBV+LrB+MS/IBrYKYqDvGYyARA
 f65w==
X-Gm-Message-State: AFuF++mpo2SOh7YEtsHnn1/IqEk6zSaA3dAB44eEpS+oJQzLNFTiDZxB
 mRu7SERwh5aZWhNbyTKdTzMjH99bOqJX+lruIrGyYYUbCjTRtt9t/uBfhjqIjceUElHAwFp+W0u
 dxcNOGgV8VIa6/nXFfdZOYFGpMv0juyQ=
X-Gm-Gg: AR+sD12i+VbznoYzW0wpauoDXsczyllSYr91UK9jn9f4VEszW9m08mRPP1hwshDEron
 wYa990Ww5j4FgjDM+6KYEdD4xzwCDevUEmAXz0UdUAVqutdAa4bSkXwf/jpVKRGnQC2KGIikz0Z
 Oit8fjYlfgDU6hZQZN1NmCXEYJd6W0TA7k0LgI4rpvb30HENqKjeyD1JMllkzzI4fGVxX0qDt6w
 dXTqY2BKnP82HYsohOgLqV3FOcTyMgsxoJN5RZbyLNuUqgoZozgOBXQnyCiaq94Ffv/OrJRG3KS
 acZIwvDujCL7WAGdwK3P/URN3v0vLXyTm+OZqA/LeW3SglvnVSMG1M9HZlqt4BRn8b/DBfavP+0
 jgq0Zk0vFxVfTJlDDaDMV7e8jIVKv+yegKLX04EpJzs3x6gDhi7ers3VByU/9UKE=
X-Received: by 2002:a05:690e:140c:b0:66e:3e4c:b760 with SMTP id
 956f58d0204a3-66e4c7d320bmr1429933d50.39.1787905540418; Fri, 28 Aug 2026
 01:25:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260827152638.307913-1-scherer.simon89@gmail.com>
 <6bde2090-3e9c-45ec-b99f-dfcc33fcb3e3@linaro.org>
In-Reply-To: <6bde2090-3e9c-45ec-b99f-dfcc33fcb3e3@linaro.org>
From: Simon Scherer <scherer.simon89@gmail.com>
Date: Fri, 28 Aug 2026 10:25:28 +0200
X-Gm-Features: AcwNN1U-mLjI57INn1OdEVNXbIR3PwUA-z659lhEzOvCkqpjgZlExYOHjdDEOgg
Message-ID: <CAEQwQtKc25GEK3uedLTcpCKhB21oEaEVp5uXPed2VOrfE+V-wQ@mail.gmail.com>
Subject: Re: [PATCH] target/i386: clear C1 for all x87 compare instructions
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=scherer.simon89@gmail.com; helo=mail-yx1-xb130.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Good point, sent a v2.

On Thu, Aug 27, 2026 at 7:41=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 8/27/26 08:26, Simon Scherer wrote:
> >       env->fpus =3D (env->fpus & ~0x4500) | fcom_ccval[ret + 1];
> > +    /* C1 is unconditionally cleared to 0 */
> > +    env->fpus &=3D ~0x0200;
>
> Then merge the mask with the previous: ~0x4700.
>
> r~

