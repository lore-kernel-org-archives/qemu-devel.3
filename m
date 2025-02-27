Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED410C021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 09:51:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnaXl-0007Fi-5k; Thu, 27 Feb 2025 04:51:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tnaXf-000790-P4
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 04:50:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tnaXc-0003Jh-TV
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 04:50:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740649851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LWAZvimGNk1tF+ANGXTAMRK6KN/D4dhCfoJh3bD4+uw=;
 b=UPKGURUMSPMiHYKZDWnrCDZUM4jUrkxBwn5p3vsw7M6aHfg/IlX4roCWiVhiEMTFiMXRS7
 PbnSBZuEp+dSryPIZk1LtUre3krHmh0/UVd8eEidJ4BvSXpXzySjj9iEIag8KBdTKV1BR+
 /8Q7O3Ovg2SzXJ80XI3w+Umwyr/WIBs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-WSQmALK0OduISmuc0IrQcQ-1; Thu, 27 Feb 2025 04:50:49 -0500
X-MC-Unique: WSQmALK0OduISmuc0IrQcQ-1
X-Mimecast-MFC-AGG-ID: WSQmALK0OduISmuc0IrQcQ_1740649849
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38f44be93a8so300556f8f.1
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 01:50:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740649848; x=1741254648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LWAZvimGNk1tF+ANGXTAMRK6KN/D4dhCfoJh3bD4+uw=;
 b=eeeY5AvRMxSgDzbi4Ak1w9pcByrYxhAT0Q0GwH/8vXsl6Zuj/4GcWlCrNtrtpz0NrM
 0bWFF0wKrkFvvIE6M9LSFK/JoVa94B/bcqRWfEt478x+ZDY199/oFId/zcCSWO0gWpTZ
 pVQQOl+NvcBktx7lvUcsI1jHLvOTH2eig75mC90FMN0/1+JsFFIsmtqJGRfFikzVmhf9
 92bnVre2OG4othYt7GtXFJy+95b9o6Dx4KbNKY2wMewSQd8rWLujHgIEjff/goCJCU+a
 mfHUWpIEh+WQcoW27p7h51pPXB1XRnhz60IJWWDv8GyiJ4okzaEEBfUTzKX3vAxZSJnF
 fZjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxMl4Fhx7H79f2QG/Wr1BoeAAE8lvDa0RgHM25yReJvrDGmcyt6EMpy4BsqCmr+TbMrwrX18H3fPe9@nongnu.org
X-Gm-Message-State: AOJu0Yz9yoac4L+C9wHXRuOVe7xVKGZ+fdqmR4LKEJUNVkpYQFJ8udDh
 zNXRAiswVqOoFYfez8g9QOs54vzu8AjgoQD48rKLq7yOk+5YHogtJR7C1tY4hXOP7cvQYOmQD8x
 AjFUOcQQ4fRzWnQtAfPZAn8RGEkDW5fGmPgZBs7YQ9RTW9qWq64h7
X-Gm-Gg: ASbGncuueBh076u68DP0UIvC9ik9394gydnoRiIiieF/0MuAkKKrK6t/tifHEJ6LP7F
 HLHUDhZ7FZe1MUL9C4R/5q42G718qQDdR2IcCnXM0svp1pHUNEjW+okkvF2BIchJg/5wasl23We
 +ypoZ1ZNpUuO7IuVRJeOpcDfcXTE1XK2aZeyukaZ4oCrEn0wXzvYZ5WAXSsmQymINoGL2zvxvy6
 CuxF+Eo087+ZaOSz62ZMRTvn76wuLbDC4WpZfQlowgl4r187DTAL88zZBAeBfIsLl6hgNKFv6XB
 4nKMhtZMucZ7OgIywU8utfX886FyxvVM5mH5WScl0ib4OSrkzgSDB+2Dhku3VhY=
X-Received: by 2002:a05:6000:1acf:b0:38d:c2d4:2399 with SMTP id
 ffacd0b85a97d-390d4f84abamr5489401f8f.41.1740649848462; 
 Thu, 27 Feb 2025 01:50:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHSS29mgKIIJPNubRNiu6XSsP4jRdBTsm+jLItodsOd+ON4krsICtKTwhV6diQM03lS5OYCZA==
X-Received: by 2002:a05:6000:1acf:b0:38d:c2d4:2399 with SMTP id
 ffacd0b85a97d-390d4f84abamr5489383f8f.41.1740649848097; 
 Thu, 27 Feb 2025 01:50:48 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e47965ddsm1532686f8f.18.2025.02.27.01.50.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 01:50:47 -0800 (PST)
Date: Thu, 27 Feb 2025 10:50:46 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Philippe =?UTF-8?B?TWF0aGll?=
 =?UTF-8?B?dS1EYXVkw6k=?= <philmd@linaro.org>, Ani Sinha
 <anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>, Shannon Zhao <shannon.zhaosl@gmail.com>, Yanan
 Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 08/14] acpi/generic_event_device: add logic to detect
 if HEST addr is available
Message-ID: <20250227105046.3c67b7c2@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250227082638.7db90257@foz.lan>
References: <cover.1740148260.git.mchehab+huawei@kernel.org>
 <e9e0aafd7cc8613709171ec5d8a6d9d9be62d7c1.1740148260.git.mchehab+huawei@kernel.org>
 <20250226165226.49b88429@imammedo.users.ipa.redhat.com>
 <20250227081927.726a1938@foz.lan> <20250227082638.7db90257@foz.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 27 Feb 2025 08:26:38 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Thu, 27 Feb 2025 08:19:27 +0100
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:
> 
> > Em Wed, 26 Feb 2025 16:52:26 +0100
> > Igor Mammedov <imammedo@redhat.com> escreveu:
> >   
> > > On Fri, 21 Feb 2025 15:35:17 +0100
> > > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> > >     
> >   
> > > > diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> > > > index 5346cae573b7..14d8513a5440 100644
> > > > --- a/hw/acpi/generic_event_device.c
> > > > +++ b/hw/acpi/generic_event_device.c
> > > > @@ -318,6 +318,7 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
> > > >  
> > > >  static const Property acpi_ged_properties[] = {
> > > >      DEFINE_PROP_UINT32("ged-event", AcpiGedState, ged_event_bitmap, 0),
> > > > +    DEFINE_PROP_BOOL("x-has-hest-addr", AcpiGedState, ghes_state.use_hest_addr, false),      
> > > 
> > > you below set it for 9.2 to false, so
> > > shouldn't it be set to true by default here?    
> > 
> > Yes, but it is too early to do that here, as the DSDT table was not
> > updated to contain the GED device.
> > 
> > We're switching it to true later on, at patch 11::
> > 
> > 	d8c44ee13fbe ("arm/virt: Wire up a GED error device for ACPI / GHES")  

After sleeping on it,
what you did here is totally correct.

You are right, We can't really flip switch to true here
since without 11/14 APEI will stop working properly.

Perhaps add to commit message a note explaining why it's false
in this patch and where it will be set to true.

> 
> Hmm... too many rebases that on my head things are becoming shady ;-)
> 
> Originally, this was setting it to true, but you requested to move it
> to another patch during one of the patch reorder requests.
> 
> Anyway, after all those rebases, I guess it is now safe to set it
> to true here without breaking bisectability. I'll move the hunk back
> to this patch.
> 
> Thanks,
> Mauro
> 


