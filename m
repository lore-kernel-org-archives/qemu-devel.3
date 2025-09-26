Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42963CAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 17:12:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2By4-0001Vt-GW; Fri, 26 Sep 2025 13:10:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v2Bxr-0001TC-Mo
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 13:10:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v2Bxi-0002JW-JN
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 13:10:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758906615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LdL6IaE0ruSoKEn84m6xdodHJNj6SpGHmsjG6bF+Y/w=;
 b=GtAKMy8mngjmMH9/EQphjvubtjCWAF5dRSkY6XbGcbNGgUjxKgtnO0iVlwozOGoFGhTSZx
 euCJApa/7PVMMayvLjGwA3+V+f1xWn9JJojb/9u97m6YwLkZlca/vnv7IDdnBt8DFI338Y
 rc0QFQsJw5gemlf/6XXhWkV1Q79d4+g=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-ZBOhgvWJM2uQ-bb3rO2MOA-1; Fri, 26 Sep 2025 13:10:14 -0400
X-MC-Unique: ZBOhgvWJM2uQ-bb3rO2MOA-1
X-Mimecast-MFC-AGG-ID: ZBOhgvWJM2uQ-bb3rO2MOA_1758906613
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-7bb414430c2so68533526d6.0
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 10:10:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758906613; x=1759511413;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LdL6IaE0ruSoKEn84m6xdodHJNj6SpGHmsjG6bF+Y/w=;
 b=b7BDBzZriWmZFsYtOLe32Y9JT+PiBoDJ4dT6A2lekw3iNt1f7KcBeWAut7BG+SFZ7z
 CNkk7A0eEcfGHXXtXA4nTnB9eLyX6XSSUWqqgls90MOjEwS70sxl3mixqyA4pqVkK75p
 zDHq9ICuXjg4eNHLTK8jj2zrGyb5u6VEGrTnciwu/CxkwkSY/JC8BrwrC5mPGtLpSTjJ
 eq/k9K1UIuaPIBUI9ZniUiBbkHJ39cSIOKcjerE35WAITToN/1cqGzTv2W7v0OYCxW86
 FzjX57UXx9ChEANxEjjGSKsIl/HHlA6EFYHQUCCeseq11GgHfSi8QtiG8D+AHduVtC0N
 4YDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWC6A7J/75RaLL4qoR9lYO5FOya9U8GYgGlQcPnxu3bbkV36Lg92UZlpGsoRztTE3fFeCjN5qz+ZOSN@nongnu.org
X-Gm-Message-State: AOJu0Yx2iZi6YWlbXna+6O5rJwwUeHF9jnr7kMVm+/T3K+/vXXtlYp+4
 lFVKHum3ZeCjPBr8FvCcWDm8opc3ZTu4a8x1wISrIPcAOdL40PEKF+1+RR7LA4HFrPHzy2Ui/ty
 8QzN7K191qsTvAVE4p1WpAsu6JhucuVTBhPOeoAHY+fjFh1vkGWQ60xgn
X-Gm-Gg: ASbGnct6UxBVl3Xl3eMqQuMitQSykrHpoI0xeytrGmXX0NXmINWopiGb+jnvpSaxfoe
 G+1VJQDEmLsYAGLZf6/P6903YLQAfLpo3QQ3lSUOmYlkY3C+JkNJf9wPkMmp3BbvqMc1LFEcmj6
 iwp5HQzWgi7ZFSqQQ5bm2FtmLgktosIeFvrsJ+gITqNY88Y0JG7janOyvd969lphO2V6AhY9bbg
 LM43z0ixhhf/V60Np657hRzePwDB95Ab5Ux06RujVV9U4wS/swigNu3r0UY8rxCw8Enf43IWq9P
 8fAYU/EZEdUwS5XtzbjtfYVUIH7caPn/
X-Received: by 2002:a05:6214:dc6:b0:78e:136c:b6e5 with SMTP id
 6a1803df08f44-83068eb8504mr3010726d6.3.1758906612649; 
 Fri, 26 Sep 2025 10:10:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGviV8pBp4PmqCWig/Rk9jNddU2Xea61cUkK99qFLi1Rg2LlVDHF5mPhaxpkFLqxauO8cUf2g==
X-Received: by 2002:a05:6214:dc6:b0:78e:136c:b6e5 with SMTP id
 6a1803df08f44-83068eb8504mr3009846d6.3.1758906612050; 
 Fri, 26 Sep 2025 10:10:12 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8016cf8eed9sm28787096d6.58.2025.09.26.10.10.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 10:10:11 -0700 (PDT)
Date: Fri, 26 Sep 2025 13:10:08 -0400
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Yanan Wang <wangyanan55@huawei.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH v2 3/3] memory: Stop piggybacking on memory region owners
Message-ID: <aNbI8KlgbyRgCZEH@x1.local>
References: <fe1969e6-bc13-4438-816d-b352926c33a8@rsg.ci.i.u-tokyo.ac.jp>
 <aMNMjetBDJfBiThl@x1.local>
 <4108b4f2-accf-4080-af29-a3f464d862f9@rsg.ci.i.u-tokyo.ac.jp>
 <aNRfHQoBgwBMjK04@x1.local>
 <CAFEAcA8wTsZiihr8-LKucTmeZwPBdnkdA-o3mUgaW1WzrADhOg@mail.gmail.com>
 <aNWgnBV-9p6UnsYT@x1.local>
 <CAFEAcA8qdWtdX0Xc0WAuT9eZsXbudV2g2=Da8pK6tEfytdMbpw@mail.gmail.com>
 <aNauXSMiP0LUWQ5J@x1.local>
 <CAFEAcA8x0mgrxepuKcPwLWfQF8H=giWH03+2sF9yzZ_5nk_dmw@mail.gmail.com>
 <CAFEAcA-Y_5ea8D82CLBuBoHAVwKqBLjpO8Q6giAGW=fXScheUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-Y_5ea8D82CLBuBoHAVwKqBLjpO8Q6giAGW=fXScheUw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Sep 26, 2025 at 05:56:59PM +0100, Peter Maydell wrote:
> On Fri, 26 Sept 2025 at 16:59, Peter Maydell <peter.maydell@linaro.org> wrote:
> > I'm trying to repro the setup I had last year, but I can't
> > figure out a setup where I can get hot-unplug to work:
> > the "device-del" command documented in system/cpu-hotplug.html
> > always fails with:
> >
> > "desc": "acpi: device unplug request for not supported device type:
> > IvyBridge-IBRS-x86_64-cpu"
> >
> > Do you know how to get this working?
> 
> Turns out I needed to also add enough command line arguments
> to get a guest to boot (which is a bit tricky when you don't
> want to use the gui frontend because fontconfig et al are
> full of leaks that clutter up the asan output). The error
> message from device-del is extremely unhelpful here.
> 
> The command line I ended up with was
> 
> ./build/x86-tgts-asan/qemu-system-x86_64 -vga std -display curses
> -no-user-config -m 2048 -nodefaults -machine q35,accel=kvm,usb=off
> -smp 1,maxcpus=2 -cpu IvyBridge-IBRS -qmp
> unix:/tmp/qmp-sock,server=on,wait=off -cdrom
> ~/test-images/ubuntu-server-2404/ubuntu-24.04-live-server-amd64.iso

Right, I remember I hit similar condition, but after I switch to a Linux
guest it started to work (with/without leaks..).  Looks like we need the
guest/firmware to respond to some of the ACPI requests.

Thanks,

-- 
Peter Xu


