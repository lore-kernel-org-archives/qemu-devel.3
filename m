Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 831A3EB64DE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 11:48:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snzLI-0007Ap-Hz; Tue, 10 Sep 2024 07:47:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1snzLF-00079k-Sh
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 07:47:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1snzLE-0005bN-86
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 07:47:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725968847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rky1ieuBPHBCSlDGwr4UcOKvIdV+vNGSet3XODcPpPw=;
 b=Fy7kgY+xxUEecB/GhExUv0Lj5Y6y9/HBfe5G0+qAprqXxAy6Jk0cVaGf4K1wIQfzRBuMNn
 ai694nuAp1AA7zMAS6uOWv7eljulHAvihf6C3nJDfpT+1ErS+7JL4d146/14/ZCdAsAjuv
 Ii8Ay++y1TKJev1WD7TH7DpgO6XsoE0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-g10FP4XzPPaR7kc4xG4ENA-1; Tue, 10 Sep 2024 07:47:25 -0400
X-MC-Unique: g10FP4XzPPaR7kc4xG4ENA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42cb6dc3365so16833925e9.2
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 04:47:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725968844; x=1726573644;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Rky1ieuBPHBCSlDGwr4UcOKvIdV+vNGSet3XODcPpPw=;
 b=JiVbXWdfWnY/ulWRv+4Iq6fNOnixhiDpcjiAbAmQ6v8XoKVYwGMyb8BMSgLQBULVIi
 r4f7t3Sguez0G9DNOvonmsSHwPaT8ICDECCrgl9KrhPPLzG5e3xltf/lxGjUov0nXKeg
 dlGZ1SjeDnWnfz41xRz2iKUE6Dd7sdQRbs9XYq0WaMvzpeyMCWSCOnzaAFq6etTr4kBQ
 SpwW4YDEMWVVP1akh6ymH3cy1lDzNUvje4Z3o6hXqeQuv88Szgetyo2n0JxKb2O2Bpjg
 9ijaV6NWH/BLPNF2KnlPqux1CnPCbnNyg0Pg0FOE34ftM9o5KB0iMM1Ni/Y2BUenmCZt
 sGVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8X5RADLIymxDE8DNAiYfgnWHDEs0orPc7oHx0g/rzr6IvMR2vAdHNP6XhR07ihtcWlt84bMGbhQzw@nongnu.org
X-Gm-Message-State: AOJu0YxfWpRJWFE4yCh5cvd8rNEGAyjnLM87oXJdo3811sdrSW7r1u5X
 ajLV6wNGELCAumr3+v6BkPcn44nAh5kq9bnqKTo3+ELMdUIvUU8IPuvYcqtGJ8QiPWXA2+GuYda
 jKVbNbFu2rCDit8clwjB+3qCJ8s+qWYbJKRlPzRphq4Z2iTtzZZdD
X-Received: by 2002:a05:600c:5128:b0:42c:b62c:9f36 with SMTP id
 5b1f17b1804b1-42cb62ca18fmr55230315e9.5.1725968843885; 
 Tue, 10 Sep 2024 04:47:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWXB7Pw2Wfct09ZYACK02NRKsJZVfuOuCVRmUKwePZ1Hyl6w8z326AUwH48g4rRLvgOoi9TQ==
X-Received: by 2002:a05:600c:5128:b0:42c:b62c:9f36 with SMTP id
 5b1f17b1804b1-42cb62ca18fmr55229825e9.5.1725968842955; 
 Tue, 10 Sep 2024 04:47:22 -0700 (PDT)
Received: from redhat.com ([31.187.78.173]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42caeb8ae9csm107888625e9.42.2024.09.10.04.47.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 04:47:22 -0700 (PDT)
Date: Tue, 10 Sep 2024 07:47:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Subject: Re: [PATCH for-9.2 v15 00/11] hw/pci: SR-IOV related fixes and
 improvements
Message-ID: <20240910074649-mutt-send-email-mst@kernel.org>
References: <20240823-reuse-v15-0-eddcb960e289@daynix.com>
 <20240910052046-mutt-send-email-mst@kernel.org>
 <08975798-2484-4aac-a032-5ab8a6475bde@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <08975798-2484-4aac-a032-5ab8a6475bde@daynix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Sep 10, 2024 at 06:33:01PM +0900, Akihiko Odaki wrote:
> On 2024/09/10 18:21, Michael S. Tsirkin wrote:
> > On Fri, Aug 23, 2024 at 02:00:37PM +0900, Akihiko Odaki wrote:
> > > Supersedes: <20240714-rombar-v2-0-af1504ef55de@daynix.com>
> > > ("[PATCH v2 0/4] hw/pci: Convert rom_bar into OnOffAuto")
> > > 
> > > I submitted a RFC series[1] to add support for SR-IOV emulation to
> > > virtio-net-pci. During the development of the series, I fixed some
> > > trivial bugs and made improvements that I think are independently
> > > useful. This series extracts those fixes and improvements from the RFC
> > > series.
> > > 
> > > [1]: https://patchew.org/QEMU/20231210-sriov-v2-0-b959e8a6dfaf@daynix.com/
> > > 
> > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > 
> > I don't think Cédric's issues have been addressed, am I wrong?
> > Cédric, what is your take?
> 
> I put the URI to Cédric's report here:
> https://lore.kernel.org/r/75cbc7d9-b48e-4235-85cf-49dacf3c7483@redhat.com
> 
> This issue was dealt with patch "s390x/pci: Check for multifunction after
> device realization". I found that s390x on QEMU does not support
> multifunction and SR-IOV devices accidentally circumvent this restriction,
> which means igb was never supposed to work with s390x. The patch prevents
> adding SR-IOV devices to s390x to ensure the restriction is properly
> enforced.
> 
> Regards,
> Akihiko Odaki

Cédric would appreciate your Tested-by/Reviewed-by.

-- 
MST


