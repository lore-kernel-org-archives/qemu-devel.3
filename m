Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B29E0C88E67
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 05:05:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5yrt-0003LO-PA; Mon, 14 Sep 2026 01:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1x5yri-0003L2-Ap
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 01:04:26 -0400
Received: from mail-ej2-x10.google.com ([2a00:1450:4864:34::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1x5yrf-0006Ke-V3
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 01:04:25 -0400
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c2507a0a24bso28000566b.1
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 22:04:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789362259; cv=none;
 d=google.com; s=arc-20260327;
 b=cSNfAqwBL3OxAcc+xWpaFI6uKj148iXUTIiGZR6aeBa2Clzsj5cE4N9mQ3EfvwCsWK
 KatZLrHJOU0q/kQtpRFuhjiJIZCHXRUI2raq4APb18ZuTskG0pe0AjslSvju5nMfG14n
 dQzUVbjj104A1RqCdaHhDKa5Ad3ZLgxD4Pn7zXgA9vOBIGM4eAni9wASQGgI1jMkuD6P
 ByWOjRI/4D7PXXDLitUAQ3C2BKkezKRLaNWdnt7nGe+gkFbSJqINeyZ4JXVon1CaMTCI
 OWpIeZGu+0OI4j9WXxv0b650qi+MgZK/6cpg0DEgsa3L0Ni4lnZ0spkNploWHf2AAYEp
 53Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2VB3iFEFnYA8+zJZCPGrAfjR0kkeL47qKyaSgDVl3JA=;
 fh=+xxEUy9FJ+CZAB7XtA50nI6rSHzay7r77rFZhazA3AA=;
 b=PckxCj71d/yN3vzYfBVARS3McddeB9AQbiYmsOUaTMzSojK7UU2KY68cs3egMEd6Yg
 3+lgvcIOi1gguGT/OJqgcoAH/GFvXwDNAjbtXVhhmAdTUzn1SrMayrHFYijNHWU+rajg
 kawkH1NnoZD1KvzZa7aiqXDCxJ68Jei4IdmWDSgdNiLCHfI5eCm/uV4Xe0qgMHbjmmLK
 OO9j233gOlZ8cbedkm3D4ebH1SkYdhYUMgdjmwYya8uwGJVB4Lr7AHtOOZAGdUeTvY0D
 1fZt0mmS1q9QXnM5gWcc+XIs2ydFhTngYPtbyQM83D4IFm71YdXEMsBsMj/4efRGVD7h
 7PMg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.ionos.com; s=google; t=1789362259; x=1789967059; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2VB3iFEFnYA8+zJZCPGrAfjR0kkeL47qKyaSgDVl3JA=;
 b=LyjuMOiNOEG86BqVfVQglEhQm36N5895G6GcHmmYpNPUYafwH/3eSyQVJbdUbON8TS
 +6df27TRoj2vXuiHnlHMIiLNS0HMdQkrPNIILl+GFKqrdLHwDAVSw3zacOUiM8hZ9TAq
 4YDenl00zAHQCpzXQeBj5FwcIdmEKokF3eOvg0R1VkyEMoF7aP7HLVsrNAoKoqotP/KL
 PNWgUl/ZWiB3fcgRJYHHYS6DMkhSlYKzvs4M9pMXHY0REhoTSLSH9OagHY3x7ju5Rf0e
 kn4coB+GNjSfxM7u+i53TuQwXitlwAT9dW3YievQTlbcDCOHvoYPsnfjOJkJFPLk53SM
 VlxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789362259; x=1789967059;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2VB3iFEFnYA8+zJZCPGrAfjR0kkeL47qKyaSgDVl3JA=;
 b=seIQr+tpzdIKmeUBSB1r9Xv9EPPXjegZqka24b+XZbrUP4A7Tn2OPVXq88cDB/1qin
 ZXgaVWgWAndyjCTBWr7Hf1o0nAaVEhJuoTcCkrjSC1R3M8swqZhtzWj8jQnta71eBXOx
 C8PKqu5KkgRm54UEUOUuhZDGGYaScZB5Z6AET1NqXYRheCatCvGiSlZUE4KklsPL8EIP
 dy7kYwws3MuSDk2roTO1bQE3XTo3rsjgppifyTYCxPJcJeezRHTlyN79+06pT+pzvmAd
 9KtmPCgIao3614TApsgUqEC/+IrWEvU8nH3/Vu4YubmKWhTvbLgdK8pHw/k4Z6thAsll
 hWTQ==
X-Gm-Message-State: AFuF++mojmaCKgz9pUsDmmxGVgIaFRmjM86gQOpPUPsnBiQ6pqtUjb3R
 LcQRyfpvuu7jdF/nl9NllaeEGysH2Rb2O2WBJPLe5CN9uPdCInkwV56myn3wT9ezKgpv6bz/e/X
 H0/JeLhH5gDu+3r51xbjrmK5i/B3wgCYertIoAlwcFA==
X-Gm-Gg: AYBFou2k+FOgWETssaNU0mR+uIkEQV3dWActAqdCiR6PUfHUXspdUiGQOzuqhnkL+lo
 qC7s1qALnk8442u+uT/jb4e7uPNZHORtsd4Gx0EfKr+voIaodX3K5f3gx48JhIXTVJRiLx6ct1t
 7PcF6M1tCiIHK+aGYyjtUp63lRW8Kqr1iXUiGQUakvYhtsdP1lRVCJ2wcF44MmYwZKXN6xPv8nr
 blLVmUT/gvh0IxiJVmhoR4FJNRHAXC9Sf/OUOL2vVki+3KpHL6bEm754wks68i1EhLySC5hU5El
 9Cq8wgHeOiUFt6dQGUN42aXetIJ8n+d91yH4HEjp/Tv867Erok1Dd/h5iUH/vShHMdAHZaISYbc
 rSdXexg/HjICT
X-Received: by 2002:a17:907:7286:b0:c25:2fb5:e57c with SMTP id
 a640c23a62f3a-c29b871b2dcmr55113166b.3.1789362259284; Sun, 13 Sep 2026
 22:04:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260913062455.940447-1-yanfei.xu@bytedance.com>
In-Reply-To: <20260913062455.940447-1-yanfei.xu@bytedance.com>
From: Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date: Mon, 14 Sep 2026 07:04:06 +0200
X-Gm-Features: AcwNN1W_ILh0KNbUKBMHxqz5HbNLPGM9yiGIQ2yJt1mDxE1xxIvf1WP8oSXEeSs
Message-ID: <CAMGffEmorCT_swNfGqZJvHyfYk7pZBPier-qu3NaFjXf-sE8vA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] migration/rdma: Allow multiple writes per chunk
To: Yanfei Xu <yanfei.xu@bytedance.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, farosas@suse.de, 
 lizhijian@fujitsu.com, isyanfei.xu@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: permerror client-ip=2a00:1450:4864:34::10;
 envelope-from=jinpu.wang@ionos.com; helo=mail-ej2-x10.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

Hi Yanfei,

FYI, I ran a quick migration test on our test machines and didn't
notice any issues with the v2 patchset. We saw a 10=E2=80=9312% downtime
reduction on our setup (100 Gb/s dual-port IB fabric, 100 GB VM, idle
load).

As v3 don't change the implementation.
Tested-by: Jack Wang <jinpu.wang@cloud.ionos.com>

Best regards,
Jinpu Wang

