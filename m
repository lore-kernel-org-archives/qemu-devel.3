Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41647CA5FE0
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 10:37:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCadK-00023I-Qh; Fri, 02 Oct 2026 06:36:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xCadJ-000237-Nh
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 06:36:53 -0400
Received: from mail-yx2-x29.google.com ([2607:f8b0:4864:41::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xCadI-0005Gk-Ag
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 06:36:53 -0400
Received: by mail-yx2-x29.google.com with SMTP id
 00721157ae682-8adb500dc50so8507797b3.1
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 03:36:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790937411; cv=none;
 d=google.com; s=arc-20260327;
 b=BLnw8J7+EwU/RrN9W+0ON+uimdVn3K1z5DVcicxueBU7Q/8uXftexrUOVgp9RAqb1T
 tpkJJNeCB6IyrmhhiEZexcQXGK4A9ZjuVM2c8RDJIw11X8mol3RghtN4heYhNpGeezYy
 aRE7NjBH1iLk8TT/bFupZUGzsmavEx/Qq4zZnbioAabXuY1BYdUCzHE4DK5XOMKcZPEw
 eSohYhjFHL1+S4euAotdrCOw9Ey9924OeYTVBeaYZO0Wit+PrvlKUzST2+vvuH+Q/s6A
 tOV6b8B/1NSLhau4dBD6a+/C1950t7eH/wBys/snSmSuRsEug4grDa+kWo5f+C3Ukx8B
 VbdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=oUCEYwkNux/SM3FpLbGhHlzWx0ByOriSAUEBeLMtcjU=;
 fh=BrDbiuabHust4eYX2NJNSsVgLOQNM/UF9WmiiykNrt8=;
 b=PM7p3nuoVserGTJlhVqOz7I6RHBLjASRzKj5KZIJ/dKLlMaPW+EJbVCBQ7iZLUVhG8
 kz/0Zd/jK5zVQhGgTRyXsofNuWd8CMHfQYphBO+Q2ZcNAdWuQen1AwajW3/9MzCJsNKT
 DuEQsjMyn92zt2yXkadFfF8dN7LKAJtnQ3/pEsV8X0wca1eAOZMeHchLRTwCBSgowRtr
 3ooDPaZ94rIhoID2hV0tUc7P490SOdlicaCwnHEYiW3kFre6n6iboNkyFO2BX5MRV22D
 AZgG9BRTrkosSNJxWVaGs/ueggo6CRK97X+yKaWusGKII08/mq9u6jSA0jj4bB2sYtrD
 18tQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790937411; x=1791542211; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oUCEYwkNux/SM3FpLbGhHlzWx0ByOriSAUEBeLMtcjU=;
 b=NahGg6V5wQk1tXjjzdTd4LaP6eODt/a+4p1dH1oc8ujOI4Z1V0TZu4xbY8S3vLlN/C
 cI8ARwXQhR51KIBK6jJ/d2T/1ri2WKjdQ9GneG2hlWuJdfCT8M7emCRB72FFpNMu8b7v
 Fjqk5+UqqOg6/tExhcNn/1FmvFmXAkxD9J/hw5ZfLskoPyG975K95PFS+mzF/Ge+vsvp
 12fqhS44CWeeOOYsgUYwn7u2g1VwZBwV5qjPYuD9JDSkNLAUa6Q95TIbrBvsXJ03XiwS
 7x4BZxNh8X2zMGpvsERQQ3xo1xadRodS5BVFiGhxyWeyIFJ92X1RT88u+m7LEYB1n3GB
 xRdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790937411; x=1791542211;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oUCEYwkNux/SM3FpLbGhHlzWx0ByOriSAUEBeLMtcjU=;
 b=mR35ArgBG3kDWrhtJWqGqNR7DRVGavNPUu5xhjOaKP6yX/g5c/0bMnU5tDuiNxA+Ec
 o3T070XYR/tvkk/oX2VQR9cRO8xpNzRJLsn+5Zs9dVpI/472XVeMRQoS8yV68MH/Ri65
 XhcSLbG7+cuVezXbyt3SicVR5hvZBf6wix781xqd28hrWKvqLOZKwcPwyXAnHbZS26lI
 zCMYGP/inqur6ghDWzmbyBXR7IqncNY9mWeKdSBfX9rmhoVrBe9gD4Qi1ttHXiBSlnFJ
 wI8G0prJw8oLOGUb3NPNXZ+5lpuAThTN19WUxz5zdxgwDdrOHZe3KsXhmRY/4qu3CLrn
 L3vg==
X-Gm-Message-State: AFq9FYI/B/K31Eua8e49koGUqJrro3kVhR5VaNxor1O1mZycx1L1vQev
 m309Aurw1mRQjAJbnctcraC+aiCFBzGpo6ifSghNO+XFxeCEgxfQF8N40FScpIEgUOp5OD11Sos
 bhWk+J8hPmy0fJEeM6RZ4Y88HtACjLrmnO9IWfhancQ==
X-Gm-Gg: AYBFou0/F6qTVvmm+h5dP3WszGJST8DNBX/3v7BndkqS0l7i6dCS4Q3lyC5apIp9uus
 kJtDse16ihhH08V9Ts1iYebkaNvJPgpEO3V5taJBBwwtVCaJmpL59gdbYGc90Ir6hdjMTVeV4tx
 TaEz1vefROyusg30P6/RSOSVyfu0iV6VWd9XeCiqhaW2Dn9BKQxEwb1+PRLiIB1hyQodGY68CTq
 H/3i4eS/Of5h6OBsRp2UhrIa7RIRdtS62DySKROIy5Vi2Le+TeeA5g8thI/eMvb4iVWEfZBAPE5
 OwCHyDQiPtdQk6+EuXN8cabncJlrRfZwt+ZV4cWKw3r0pksg16MVBS0cWWndu+EcdQzueFlM8Ag
 5p4WrCzcsV7NGX7F3kDTwqpTk3EfBQF66/tTbzyU=
X-Received: by 2002:a05:690c:9988:b0:89a:63da:cbe7 with SMTP id
 00721157ae682-8ae3a5ed914mr9513357b3.45.1790937410556; Fri, 02 Oct 2026
 03:36:50 -0700 (PDT)
MIME-Version: 1.0
References: <20261001194756.3003085-1-peter.maydell@linaro.org>
 <b9019487-979f-4b37-9c30-3fc43c308d06@oss.qualcomm.com>
In-Reply-To: <b9019487-979f-4b37-9c30-3fc43c308d06@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Oct 2026 11:36:39 +0100
X-Gm-Features: AclHuK-yfFOg3f1SJlcsG5E9lczz6Vu3ns3dzELweMEJY18IwBcr4_vA9gJtXPo
Message-ID: <CAFEAcA_mTJiq-hn-_h=p6Ksi5GS62nqG9i9af4QK5Qc8QWm4VA@mail.gmail.com>
Subject: Re: [PATCH] hw/usb/hcd-ohci: Fail iso packets sent to non-iso
 endpoints and vice-versa
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:41::29;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x29.google.com
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

On Fri, 2 Oct 2026 at 11:31, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
> Side note, I don't get why we copy packet data *then* return
> error if device not found (trace_usb_ohci_td_dev_error), this
> is sub-optimal.

Yeah, that's a bit silly, but it will never happen in normal
operation, because a guest is never going to set up a transfer
to a non-existent endpoint.

-- PMM

