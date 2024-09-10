Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A4FEB64DE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 13:36:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so11S-0006Vs-8g; Tue, 10 Sep 2024 09:35:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1so11Q-0006Ut-V8
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 09:35:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1so11O-00030N-Pq
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 09:35:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725975305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p3iYod1LP+NvrgaAgNQI1w++daTf+uRij0TzPl7NgCQ=;
 b=Cj65q8JneC6myehKWIWSq2jj6O2q0Y2T/3Fj1MO13TcU7boyCWfTCGvHFBU6rgpzPwpo+e
 mvqurqByQpa4HFX9RP6Vm7JQTMCxAZpmzJud6orEUIaphhY2EgAe4HsxQVzhFPPl5IS6ha
 w9aBN1luHgmJnlAnh3j7EulNl+mmXDA=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-z8g8XRz9PieCGtR-3PGqxQ-1; Tue, 10 Sep 2024 09:35:03 -0400
X-MC-Unique: z8g8XRz9PieCGtR-3PGqxQ-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2f7593fbcecso39608791fa.2
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 06:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725975302; x=1726580102;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p3iYod1LP+NvrgaAgNQI1w++daTf+uRij0TzPl7NgCQ=;
 b=CT2iCn4c0fAS5vQNro7BqSvynSDqk6Qxm0JiUPf1DRzhz583+r8X6xDcQhV1/D8Dba
 MORvTsi8imGVc6n+2A/itiLbSREcPosE7UR8eWIy3WG/VK0KHR15VFbudwBL4/nA97o/
 6OhzDkxsFKScqIa3kEP1NH0pZvJamvr163Sy94bFBghZy+l3aWaFB31cz0ZVogQ1ORzG
 O5P8txlQQg1sSxLVdA9GJV5pMbJ+ezepYG4wKlurhzRFV87QtD70qnC7HhgHNho5uQnH
 VbYiUzp2JGHjjz1z34gorHBXkylIDbQRkryCTcQc7WiczvFFgZ85lG3LAJPLXMz8TYu1
 zP9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaH+vXPXmoPshtwjN7p0vABdoxss8Jo31zfRjk4IJfBzUaATXnqzqanm+UlyknrLOp2T3FRFEnFp6M@nongnu.org
X-Gm-Message-State: AOJu0Yy8rNz7YChISygaSygL//GgvIRStn288ZedXtqsVwZ9MS3g7/4U
 THDotG0Sue4RO3XX6jlK8fGAZsOMZqb7PCImbOyP5DIdignf97xRkk9m6lGMyXefoGejjvaA7cY
 s3eEJS2PSoazJZg0w8NIKM5Gf9r1R3F0KSDI/fej0RewTcUykye9l
X-Received: by 2002:a2e:619:0:b0:2f7:712d:d08 with SMTP id
 38308e7fff4ca-2f7749e9fb7mr14497551fa.23.1725975302245; 
 Tue, 10 Sep 2024 06:35:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9q/sM6gVnnSpQMvIzPMz3Db4OPEzkrrdjvlES/BCkzl6oXbPV2uPLeRplNwNHhiWuRT53Sw==
X-Received: by 2002:a2e:619:0:b0:2f7:712d:d08 with SMTP id
 38308e7fff4ca-2f7749e9fb7mr14497081fa.23.1725975301156; 
 Tue, 10 Sep 2024 06:35:01 -0700 (PDT)
Received: from redhat.com ([2.55.8.249]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25d3eef7sm483767566b.192.2024.09.10.06.34.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 06:35:00 -0700 (PDT)
Date: Tue, 10 Sep 2024 09:34:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
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
Message-ID: <20240910093440-mutt-send-email-mst@kernel.org>
References: <20240823-reuse-v15-0-eddcb960e289@daynix.com>
 <20240910052046-mutt-send-email-mst@kernel.org>
 <08975798-2484-4aac-a032-5ab8a6475bde@daynix.com>
 <4adc32d0-02c1-4375-8618-2692a9b1da76@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4adc32d0-02c1-4375-8618-2692a9b1da76@redhat.com>
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

On Tue, Sep 10, 2024 at 03:21:54PM +0200, Cédric Le Goater wrote:
> On 9/10/24 11:33, Akihiko Odaki wrote:
> > On 2024/09/10 18:21, Michael S. Tsirkin wrote:
> > > On Fri, Aug 23, 2024 at 02:00:37PM +0900, Akihiko Odaki wrote:
> > > > Supersedes: <20240714-rombar-v2-0-af1504ef55de@daynix.com>
> > > > ("[PATCH v2 0/4] hw/pci: Convert rom_bar into OnOffAuto")
> > > > 
> > > > I submitted a RFC series[1] to add support for SR-IOV emulation to
> > > > virtio-net-pci. During the development of the series, I fixed some
> > > > trivial bugs and made improvements that I think are independently
> > > > useful. This series extracts those fixes and improvements from the RFC
> > > > series.
> > > > 
> > > > [1]: https://patchew.org/QEMU/20231210-sriov-v2-0-b959e8a6dfaf@daynix.com/
> > > > 
> > > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > > 
> > > I don't think Cédric's issues have been addressed, am I wrong?
> > > Cédric, what is your take?
> > 
> > I put the URI to Cédric's report here:
> > https://lore.kernel.org/r/75cbc7d9-b48e-4235-85cf-49dacf3c7483@redhat.com
> > 
> > This issue was dealt with patch "s390x/pci: Check for multifunction after device realization". I found that s390x on QEMU does not support multifunction and SR-IOV devices accidentally circumvent this restriction, which means igb was never supposed to work with s390x. The patch prevents adding SR-IOV devices to s390x to ensure the restriction is properly enforced.
> 
> yes, indeed and it seems to fix :
> 
>   6069bcdeacee ("s390x/pci: Move some hotplug checks to the pre_plug handler")
> 
> I will update patch 4.
> 
> 
> Thanks,
> 
> C.
> 
> 
> That said, the igb device worked perfectly fine under the s390x machine.

And it works for you after this patchset, yes?


