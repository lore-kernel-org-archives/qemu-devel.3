Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C87CA1005
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 12:08:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut3Jf-00047Y-DC; Mon, 01 Sep 2025 08:07:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ut3JU-000416-93
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 08:07:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ut3JK-0005Uj-OH
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 08:07:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756728409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G2PufC8xMuFJnV16F3+d4vkcKy+ZYp3njmyijDgjIl8=;
 b=GGsMWl4k5nYu1MYF5Xk098TB4NPi+is5AJ3MRZJkuGWi0ElP5zjZRkWFpP9cuxww9QlIWT
 qRlaaZ0x9RYuJqVYtxXdLOgnH1r28/DrgpZWRpHeZXTMramSXjXtts+p+VAOnETKgg+x8g
 uni/2EoIlmiPfp4aaUNQKwjEjdwEOkg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-UCSawtkCMv-kzNsroxETvw-1; Mon, 01 Sep 2025 08:06:48 -0400
X-MC-Unique: UCSawtkCMv-kzNsroxETvw-1
X-Mimecast-MFC-AGG-ID: UCSawtkCMv-kzNsroxETvw_1756728407
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3cd821eaac8so2612315f8f.1
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 05:06:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756728406; x=1757333206;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G2PufC8xMuFJnV16F3+d4vkcKy+ZYp3njmyijDgjIl8=;
 b=gnnzT1o9yrTotuZlmkewQwQDKU2OEHOngG9WEBImLXS8RGSlVQyV12N9Z0E8s41xod
 whMUhtJkQigpOk/1q3A8bvngcivvi/J/aipUMYuRPrYGvE7GiSKWFiadNdWNi7UQFyVc
 f+qkqf8B2/SDNmjo9H/JmviWp4vaq8iylrTr/t6a6rmX9DTuO2J+9qLpz+K/fR5MpzO+
 M4p6TzZmgDdR1HdVNqItgnmQDaEDj6TxN2bDEKsCNpX2zBweCYN1sTL6yrxo5YTvOsEd
 1ebuJi24tUtk0WApIUCfPNe9kOW9idL5u4Jzpuc8AATJaNDLBgvDnqmXPTlv6fm/SR1O
 19ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyS0pQ85w6sZEaxVZAIPUbjwIdHp9UyYi8Oi/3/pgcxahWEqZ6Nabg/oLE5L/c9eC5HD+6y5OZjASw@nongnu.org
X-Gm-Message-State: AOJu0Yw0rkDWgiJgZZPnyU40tMSyjt2LFODI791xP6Cq8apsyuDHva3M
 l0W9aVDxVFycSpr3Ote9JT8ossNYIWu98ej4PCfqv+3F9WeT4zMHXnePVMeGFa7XdnYgf+pHvvQ
 kaorRghoUQ/FZBNOCJiTaHQ2qs36jusIBMkIMdtLKPkFjTI7T0txZ8Y6hn3362vbyRSY60gqxFE
 HSEJcgVCqqxXmnEjrchIJqUPbU2OPgPOY=
X-Gm-Gg: ASbGncstKVSDu20UKMW+nWicxzYAlB+tBMltvMRlsfOxeBTpK6G5BN07HFdUWRwiCcp
 F6hXyA3DVPvHuBsW1HCt2RUbq+J2JePr1LUYYOBEITjoHwe7IGEgBzFa5VLWOAMzUX9m1rOP2kQ
 MpF1IEXZK0V5/JA0Iq6xDBbaDuurmZRzPlFLyALj1JpxRm0VnV/3UJdXNQF3Srq5cE3BdWaCa35
 shbLVbKiFP+684//gavOOR+
X-Received: by 2002:a05:6000:24c3:b0:3d0:ef30:d332 with SMTP id
 ffacd0b85a97d-3d1dea8dda6mr7279337f8f.46.1756728406464; 
 Mon, 01 Sep 2025 05:06:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTeR95n/1gwuTu55O4uFE4V9bLm1YiQlaIbWWhyNWh3xRNw18YIAOfRvImO7sNV2TgAwW0IiU6jjDfZ8yvRgQ=
X-Received: by 2002:a05:6000:24c3:b0:3d0:ef30:d332 with SMTP id
 ffacd0b85a97d-3d1dea8dda6mr7279282f8f.46.1756728405942; Mon, 01 Sep 2025
 05:06:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250814160600.2327672-7-imammedo@redhat.com>
 <20250821155603.2422553-1-imammedo@redhat.com>
 <aKyBFlCtnxnP9kt/@intel.com> <20250825171912.1bc7b841@fedora>
 <aK1mHGan+n9NSAOk@intel.com> <20250826104731.1440e3ed@fedora>
 <33661ea1-b0aa-45b3-8923-0b47a40dcea8@redhat.com>
 <CABgObfb6Hs8EOeLQeG_S=Y8j8dj6A9fAMn0DzSSVKZYBG_rP-g@mail.gmail.com>
 <20250901140510.2925ac85@fedora>
In-Reply-To: <20250901140510.2925ac85@fedora>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 1 Sep 2025 14:06:27 +0200
X-Gm-Features: Ac12FXxf6ywKvzlstJ-fch8fYv7U2_XtMW0NswZ6O3nTf3Z4fWOaP61kaMQ_A1Y
Message-ID: <CABgObfYpB_gQd5=DFPR0mWBJeaNeeK9n1SUONUKCFy=7da4zOQ@mail.gmail.com>
Subject: Re: [PATCH v5 6/8] add cpu_test_interrupt()/cpu_set_interrupt()
 helpers and use them tree wide
To: Igor Mammedov <imammedo@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, qemu-devel@nongnu.org, peterx@redhat.com, 
 mst@redhat.com, mtosatti@redhat.com, richard.henderson@linaro.org, 
 riku.voipio@iki.fi, thuth@redhat.com, pasic@linux.ibm.com, 
 borntraeger@linux.ibm.com, david@redhat.com, jjherne@linux.ibm.com, 
 shorne@gmail.com, eduardo@habkost.net, marcel.apfelbaum@gmail.com, 
 philmd@linaro.org, wangyanan55@huawei.com, peter.maydell@linaro.org, 
 agraf@csgraf.de, mads@ynddal.dk, mrolnik@gmail.com, deller@gmx.de, 
 dirty@apple.com, rbolshakov@ddn.com, phil@philjordan.eu, reinoud@netbsd.org, 
 sunilmut@microsoft.com, gaosong@loongson.cn, laurent@vivier.eu, 
 edgar.iglesias@gmail.com, aurelien@aurel32.net, jiaxun.yang@flygoat.com, 
 arikalo@gmail.com, chenhuacai@kernel.org, npiggin@gmail.com, 
 rathc@linux.ibm.com, harshpb@linux.ibm.com, yoshinori.sato@nifty.com, 
 iii@linux.ibm.com, mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com, 
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Mon, Sep 1, 2025 at 2:05=E2=80=AFPM Igor Mammedov <imammedo@redhat.com> =
wrote:
> On Fri, 29 Aug 2025 14:33:57 +0200
> Paolo Bonzini <pbonzini@redhat.com> wrote:
> > Rethinking about it - this can be a separate patch that also affects
> > cpu_reset_interrupt(), as well as all cases where
> > cpu_reset_interrupt() is open coded.
>
> I can take care of replacing open coded cpu_reset_interrupt() cases
> (I've already looked through them, while answering reviewers questions)

No problem, I've posted my patches last Friday.

Paolo


