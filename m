Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9689E606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YhkkBAWN;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=I5fyxTdV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTegn-0001su-55; Wed, 18 Nov 2026 07:23:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTegl-0001si-Ho
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:22:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTegj-0001Pi-VO
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:22:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795004575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fGO6+pC4c4TPgWz98Wkn7/Rkqoyo/1NbWrESH2SLh7g=;
 b=YhkkBAWNBbgCiiTzlV4JOI6qL95djlsoAXQqZibykgCrsTflHBqx+0ePIO5SOqo8ZxnmI3
 DyHGfrps+tcTOUTnlp81+UosmpdTUtQ1ILieHSf6L3UZDpfGh86K6905VhoI98yZhKk3Dr
 yTqvkpHymmft0RAh2PoHtdXm2WbAAVk=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-O-fAbJvEPFqIvBNmsqT1NQ-1; Wed, 18 Nov 2026 07:22:54 -0500
X-MC-Unique: O-fAbJvEPFqIvBNmsqT1NQ-1
X-Mimecast-MFC-AGG-ID: O-fAbJvEPFqIvBNmsqT1NQ_1795004573
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3b3ad195a96so842606a91.3
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 04:22:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795004573; cv=none;
 d=google.com; s=arc-20260327;
 b=HOZij0r/WtG35wkxnawS5dzCPlIHmVinnwyNjraWxQ4OysnRTCDEQmpVZI5y0RRCIp
 9qZoC+iDyJn4mRYbZ8Q4PUzXXe4pGcjwiWD9LLsFpMzlmMrA4IWH5eQrgsoZQK4tm1Lp
 JffA0GiE2smmvOPcHGApk9Anri+c8DWoB2KfkCenGeelBS/OT4/HwYitDBM46jj2bF0y
 Bkeg4+bU83mg54+oDx+AYH5ZIIOfHtNsKr+M3abX2EUUc97TPnmp/D4ab0ramzcRHRrC
 sUvKre1yCYkrH9ItRSgtBZ8/PKmYC1bJysvwXxx4qVv5YbwU0X2utZpcRZGBvGuXs7TP
 j4oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fGO6+pC4c4TPgWz98Wkn7/Rkqoyo/1NbWrESH2SLh7g=;
 fh=GIuGC8abPYLc688GtEETDsreMB5FPLYUiMH2dX0rNho=;
 b=VsxKvP4h8z9db/acaGmesmzgQ37tibHtwBMdn39U/mTaHHKD03TTqR0hu7V2OfMcVp
 ZeyxMuNPVwkOGvPBlrvVPO/VmedudiDkC1ayqQ1R/vXHQt4S8KoeZ0arkdrf53BazR9r
 I6DH7yKrPWeIQ0TZyaq9Sw7/DLc5GPZv89A88iVUcgmSuZZk8pmh+NTpUnsrLqascfKB
 Ljr27ujUQdcWI/TsY38Hu/aJJlA8nXW8sOcoiMoN2eMu/ywRGdx0zuWic7OCABMmmovQ
 Sy6zjaFGdvSF79mX+06tmssi5zLeXF/zn6OrY2xeSE1kPZYRBawzczMqsHaMJK9kb+TL
 DFBg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795004573; x=1795609373; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fGO6+pC4c4TPgWz98Wkn7/Rkqoyo/1NbWrESH2SLh7g=;
 b=I5fyxTdVgjCaCMcVnPcGqomDgbh/z3eRScouSFY+Dv15Jq2y3QV7NkJ121kTL3MT6t
 TBQRLqHpvojyzAX2n8lSiQQRcyrYMMmSQwv5u3UXtJv3rvHfVXuQ5AxmS19JNjuQW2JT
 1G9v7lQiAszo0euyI0/Bv8LuRLKUX6e+zwzvrsvwV8k268o/pVHsv6wTJcdg8v+G1vGT
 WvggljGTMLaVmPwgKxLIysio15kdbV5/WY4eZePirBtrbtsD+TvImTyxEUQFK+ILrA/3
 2dda7eIImrq/qe2e56dVwRUYrm6kbug7cVKcih34N4vjfrfdXtdrzI/65sqw1Jg5drjC
 M1eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795004573; x=1795609373;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fGO6+pC4c4TPgWz98Wkn7/Rkqoyo/1NbWrESH2SLh7g=;
 b=bNj9DWFM/zQMooSc+YPQDrPYO5IPmSphXl5t118WqycpnuIdGRxM4beOfmXHz0+Fjd
 JsDkoiiGff6BwV+scrzl2l5t3D9ghTgwnAqFGfVcpPQZ9Td829sGPNbV8Rvf3SciCnEV
 lVF2r+i/bIh/KkVOTOFOAXepjDhBGZTfTc30GlT+0MtJKiIna1zf/8MGL205p8NGXam/
 pLEX7sab9FLBaMeNqBavgPjvAsEO+SYrk+pz79n/NqZydJ08VIUdk//AcY6EGJS7cQCb
 NaZr2d2jxl4jlsosrDxXFMBB+61e+HS2O6w6RA/h9+9W0iO2Eb+9nps7rW8kx4FJPYa+
 ekaA==
X-Forwarded-Encrypted: i=1;
 AL+hErFFRwr4LjNoH4y5K+RBEhcrc/0JBcmalr9f8irqQHLKpcR3Yuv6KQnmVer9dCy4TFdGsjnlvz7PWtyu@nongnu.org
X-Gm-Message-State: APuU4Z+xlwRMOMiXwfVFcvC47iMwOsi7ayiF+JrzYgoBpNJkj5vkDYXf
 RZDtocX38YoIeDC+B9qQL7KdQ1ozDutudxCb30Ewqh0WMgF+R2Yf1cdMBRKNbSW38Cn+UURWghg
 PXubA8nxrO8gd7yta8uAznBErc3Xfv71YVNpBwv2fsGzB0V0qbRVViEA/IzS93Mr2EFKlSq92i9
 MeCV2VddMFwGOt5oUYn18E+0qzADbPOlY=
X-Gm-Gg: AZFdTZeGuIqO+IGtawqx2Fc0j+l7wWVg+YP1AUYPIIheFj1nC499DtxyeUKEIH0zcrw
 QTxNv4ZsASCQRcrRq1so43ShXAJRMJ1/cxf/G7l6nEPIvODdNjLkyCOXYJ6MhNLPnnoDLFkhWsD
 yzueIgGzKpbq6F1+e19A21nW+McG07G9NBLL1sTjLSKrZm2K6DYv1atU5wZXQkQCNsOPI3ol0bY
 izDQ6NXsAPxmoEYHF0JS/ZGgWcYD0g2CkHqr9HAIe6XGrkrp5mbXGkZNhlG
X-Received: by 2002:a17:90b:3a50:b0:3b3:b71b:b01e with SMTP id
 98e67ed59e1d1-3b3d0850f5fmr2555055a91.64.1795004573234; 
 Wed, 18 Nov 2026 04:22:53 -0800 (PST)
X-Received: by 2002:a17:90b:3a50:b0:3b3:b71b:b01e with SMTP id
 98e67ed59e1d1-3b3d0850f5fmr2555028a91.64.1795004572597; Wed, 18 Nov 2026
 04:22:52 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260930085433.830743-1-pbonzini@redhat.com>
 <20260930085433.830743-2-pbonzini@redhat.com>
 <CAFEAcA91XU=_hS3iB+0p7hXQ_nvf0YpgNZaKsd=b=fSVaTJDxw@mail.gmail.com>
 <ar_FXE5rzVqKcTc4@redhat.com> <87ik21vy11.fsf@pond.sub.org>
In-Reply-To: <87ik21vy11.fsf@pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 18 Nov 2026 13:22:41 +0100
X-Gm-Features: AclHuK_uz5qsf8QVEVBAybdIVa1B1oKb5BD42Wc6oC7ty3k7d2j_JjIz0xfnBes
Message-ID: <CABgObfagz=EvmYtNFBo2xyDdXNkFPK8k0-YGDs7aVS6xRKEJTw@mail.gmail.com>
Subject: Re: [PATCH 1/4] docs/devel: relax policy on AI-generated contributions
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, 
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, 
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Warner Losh <imp@bsdimp.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 13, 2026 at 11:14=E2=80=AFAM Markus Armbruster <armbru@redhat.c=
om> wrote:
> David wants to do the same but with AI.  He "pre-arranges", and Bob
> agrees to review.  Does Charlie get a vote?  What about me?

Charlie the co-maintainer does "get a vote" on merging, yes, and she
is free to leave the review to Bob as well. Well, technically we do
not operate by voting, but co-maintainers are supposed to operate by
consensus and this is no exception.

You the QMP maintainer... it depends. Probably not if the only change
is along the lines of:

-{ 'enum': 'Accelerator', 'data': ['hvf', 'kvm', 'nvmm', 'qtest',
'tcg', 'whpx', 'xen'] }
+{ 'enum': 'Accelerator', 'data': ['hvf', 'kvm', 'mshv', 'nvmm',
'qtest', 'tcg', 'whpx', 'xen'] }

Even larger QMP interfaces may fall under bullet #3 - parts of large
code changes - but you definitely get a vote if there are substantial
changes to code you maintain. No doubt about that! This is just normal
interaction between maintainers; I think we do well in that respect
and I see no reason for LLMs to change that.

We may have to become more accustomed to saying no to contributors and
even co-maintainers, but I think we're good at building/accepting
consensus. I'm sure that stuff like the Meson migration was seen with
skepticism by some members of the community, but it was accepted
nevertheless. (I hope it has proven itself; and I was also on the
other side of the fence with Pierrick's recent tests/tcg overhaul,
btw).

Paolo

> Charlie and I can of course leave the review to Bob.  But we'll have to
> live with whatever makes it into the tree.
>
> I fear this risks creating resentment among maintainers.
>
> [...]
>


