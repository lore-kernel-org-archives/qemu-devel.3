Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66120CE8D4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 15:53:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJw5l-0003QN-RC; Fri, 14 Nov 2025 10:52:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vJw1n-0000im-6J
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 10:48:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vJw1k-0004u9-4E
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 10:47:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763135274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AHBKDX8ASMXvi+a2pal/xqTEa9d7Gp6ROWoUeur6E5g=;
 b=eqM4CKvsspIQS51XpSjVpmizuw8CxfsUK4lxM8xSZOI/UbZx39JWlwHNtDVbuvK66fiBMx
 9dJEmwcGJ6yD3LP6QQfChRnCGC0OUaBdTXnTBY/3t74l624FJdf3v+4/3wMDjVqQbvaCJy
 UsOUBOIAfWF0QEzu+J+sPEnPTfXATbo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-pkFrz35nPuC0puV4Sj27Eg-1; Fri, 14 Nov 2025 10:47:52 -0500
X-MC-Unique: pkFrz35nPuC0puV4Sj27Eg-1
X-Mimecast-MFC-AGG-ID: pkFrz35nPuC0puV4Sj27Eg_1763135272
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8b22d590227so288629285a.1
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 07:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763135272; x=1763740072; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AHBKDX8ASMXvi+a2pal/xqTEa9d7Gp6ROWoUeur6E5g=;
 b=KbUhJ0dvIGIA1mS4NNtQ2rzdLkwnZKrH+laqO/7Lo1QvjvTX8q7MuVYR7imA0yGXcO
 2NVu28I1Y6cQigilLfaX8cnXWtEnFttzQNuYuIrfI53jesHKE9LB/ihSgofMVPdhB45I
 CijlXyul+ccZGyO2DqXua4z70LifsydMG5XLo3P1eLc3H55KoYNo9+ffIn7G9v6NlpZ6
 QlhfVO5d1gaCD2TxwpRCX+PkEdAAViDnZNoMEDvp9AGql314MobFhdPOh+f34veQJWfR
 oglmdni3NJ4rvMRTGNk6dpQes88IrJcxgw+c0gZO+7N8oWnu+6ckYtuazCMjbn2J4rtd
 A2Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763135272; x=1763740072;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AHBKDX8ASMXvi+a2pal/xqTEa9d7Gp6ROWoUeur6E5g=;
 b=DBg5FgSm4eSBo4mZWLvAWwwU7wRq3uTjJcs4z4qYd6zQmJX3/EoM0jQNQoqkIQ4DfE
 ptigEQBZLNeUZskqRcrE7LLFnFdfBP0wQNPFudKG/SieByX2CD4AIuU/3jaJedWES1Dv
 ju051DK8Ho+L2oE40dIaqzLdoWQLqiqTAkheaZN1SG5J6Mu1UKwO1oWS0hmcSJjWxPZ5
 1EOEn2gDQWvPMDscSH3gfl3/209jSi8XlZIliNDYudCPyXHiEr/eTFigVb1/j33lKTz3
 hItp9wBB7rHtmi5rg2a1zulApqakPMk+d5jRl0mPfRV/WK8KJ5+xtlYHPNd74LRKledR
 xSLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHYisTJT5tWcJvTA4qpKgg54HS1NVhv+HH966UNOCo/DkFvMhLdpQIHUXyxcVGOJzeCHaOtt2nBw2A@nongnu.org
X-Gm-Message-State: AOJu0Yw0xJNSsa4YfsxKkFpSf3epAjtetC052S7A56aH66aMIECWvtPU
 X/4yYRNqsCDqiM1SDXB83eCjArx9fhuN4Bkam7wmZYVW14NGJz5TrgRYqDXQVv9HFq5/9L7QdQw
 8wGMPb3Pya8Yl8C4Tq/f5pzI3hue4dYJDQBxBx7BsQ/fUHSWRv6rtpjZ7
X-Gm-Gg: ASbGncu7yizKEB/VHldMS+zKwvyI/oFbseJp3yjI6R0P9+p5dCYLBHuL6a6dOv6RX3j
 H9R1fcRWSy41oavQIXVwBIOG3MFeZl2yzMSJQ6bz/SHQbhvCUc5gERApnFv5ZDBQ8aZKhfGyQZi
 u1U4K6LclkE/Wxtmx4SURl1fL66+5Ushlk2K6t+BvGJ+yJs2osJN50zjsdEVY/mGTdXUZRHLSlb
 eRAGNTyVmoHQ9oRObcjvBlkvWYGBeJ50faPCXl92N+OljCP3EEgvchOHbtpFBLWKss2rbZLnPRB
 46FQEy7JThQ3xvowdaH0xj8seNfIgJLQo5lgs/37R4bm7acw2d0SFiJ6mjPCacdp4CZcPRpe4+C
 28Q==
X-Received: by 2002:a05:6214:5014:b0:87c:1d41:575d with SMTP id
 6a1803df08f44-882925a3fc3mr43930256d6.3.1763135271996; 
 Fri, 14 Nov 2025 07:47:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH19o6AExZE/EvVU7uXWcv4X6nL5ukhRqC6MiHzwuwP6G4k6F49ert2lKxsLuyVpw7rIYKpjg==
X-Received: by 2002:a05:6214:5014:b0:87c:1d41:575d with SMTP id
 6a1803df08f44-882925a3fc3mr43929876d6.3.1763135271432; 
 Fri, 14 Nov 2025 07:47:51 -0800 (PST)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88286531229sm32808096d6.34.2025.11.14.07.47.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 07:47:51 -0800 (PST)
Date: Fri, 14 Nov 2025 10:47:47 -0500
From: Peter Xu <peterx@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, qemu-devel@nongnu.org,
 farosas@suse.de, jinpu.wang@ionos.com, berrange@redhat.com
Subject: Re: [RFC PATCH] virtio-net: introduce strict peer feature check
Message-ID: <aRdPI1zDKdvndxYx@x1.local>
References: <20251107020149.3223-1-jasowang@redhat.com>
 <20251113110004-mutt-send-email-mst@kernel.org>
 <aRYJRZyNrDcDzTuG@x1.local>
 <20251113114710-mutt-send-email-mst@kernel.org>
 <aRYRhg7lKDCBUIrf@x1.local>
 <20251113124207-mutt-send-email-mst@kernel.org>
 <aRYyTeNNIPW_WIJW@x1.local>
 <6a83ca08-5484-469a-8020-a1165aed1c73@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6a83ca08-5484-469a-8020-a1165aed1c73@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Nov 14, 2025 at 06:48:42AM +0100, Thomas Huth wrote:
> On 13/11/2025 20.32, Peter Xu wrote:
> > On Thu, Nov 13, 2025 at 12:46:55PM -0500, Michael S. Tsirkin wrote:
> > > failing to start a perfectly good qemu which used to work
> > > because you changed kernels is better than failing to migrate how?
> > > 
> > 
> > I agree this is not pretty.
> > 
> > The very original proposal was having extra features to be OFF by default,
> > only allow explicit selections to enable them when the mgmt / user is aware
> > of the possible hosts to run on top.
> 
> Could it maybe be tied to the "-nodefaults" option of QEMU? If you run QEMU
> with "-nodefaults" (which you should do when planning a migration later),
> these extra features that depend on the kernel version stay OFF. If you run
> QEMU without "-nodefaults", QEMU could enable them if supported by the
> kernel. So that would benefit both, the people running QEMU via management
> layers (using -nodefaults), and the people who just want to quickly launch
> QEMU on the command line. WDYT?

Are the "default set of devices" when without -nodefaults more or less
stable (aka, still live migratable)?  If so, I wonder if there're still
people relying on migrations but using default devices.

The other question is, such proposal also means auto-probe will be OFF for
all serious users.  I am personally OK with such, however it means it'll
also reduce the test coverage that Michael was looking for on new network
features, when QEMU is running on new kernels.

Thanks,

-- 
Peter Xu


