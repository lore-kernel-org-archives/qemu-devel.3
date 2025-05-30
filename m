Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08234C5B549
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 11:36:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKy1i-0004ZQ-0Q; Fri, 30 May 2025 07:35:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uKy1g-0004Yh-Fn
 for qemu-devel@nongnu.org; Fri, 30 May 2025 07:35:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uKy1d-0001kY-1V
 for qemu-devel@nongnu.org; Fri, 30 May 2025 07:35:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748604948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SmjtuBgro1iLL+lQ7PfSG+YZIWnOMKtg8axX21EwLnc=;
 b=UcxFljqU23PBFuF0OHwuBhiYVKFXU/pZRVwjLLdwKWT/2BXNwlURA0GQKcZ4hLsWx9ZAB/
 Veyc4wTjv8cO42XlWIgP8Ko23Kl0zryOMAF0dlVdr06hN0G6mQMUpkk5+i0StysgSVxLD0
 yW6kOP+Vci46f9v+WFB6oELOwiz8faE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-Yucga7CINBysqQ621zcgmQ-1; Fri, 30 May 2025 07:35:44 -0400
X-MC-Unique: Yucga7CINBysqQ621zcgmQ-1
X-Mimecast-MFC-AGG-ID: Yucga7CINBysqQ621zcgmQ_1748604944
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-450cb902173so9149805e9.1
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 04:35:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748604944; x=1749209744;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SmjtuBgro1iLL+lQ7PfSG+YZIWnOMKtg8axX21EwLnc=;
 b=KU2rJggCuilBk4qZDcEQFO45i9uO3z5xG3/IGslUEoTuvHs7b1vRkrTVuwD3EBvlwj
 H/uayo37Z4FAuar5RrWawM7S7IHxkILErTl+zBsWXpfF8a1gduAmHci3bYWb+Z/kzSy4
 LKuOFRmoMhKTvW+HERWzvQNcjgB7nBovW9BOQTN2xijryF2Wb1WEAsBN8U+KirmpP9/X
 GnlMpvOkCrh22zRJpOPjA6to6l0uqfoI/toXDQ08mMKs3xB8JrF/J3Yi1WgxLDeJR5CA
 ISxN9QXjFfYquqKkkTythgINFeAo6TA4OW6pE4ent3eF2xcRKiK+hPwh+R0p4xJJIDEF
 mjRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUugGRwbvzfnoyaYzgOVWE9NYaoYR9au2orBhgTmBaMtrAPmJPbVCeectnt8EW2nW+sAktwfz6U1gYq@nongnu.org
X-Gm-Message-State: AOJu0Yz87tqv6bB15+mIldiK9xC0lQQaALsHk561D+PkOOJd2cxtP+o9
 D5jnAaeRVuWPQelfVnevcOYGrsFexEtlFSyJ00PeI8LrNK4sDWAo8eKzvsRNBZlv2DMev2ojEHL
 7ysHDZ82xCkfLvRaMVtooFzs8R8V/T+hHaCozf2ZmJ8j7fsEWqwSAs3Qw
X-Gm-Gg: ASbGncuEXMjcNYrExItyGkVoCzt6G4D8A9NmEBF/ezS8y6A/JFbKhJpV6L1Qsr0SkqF
 GVn5GZguvgyFLnRfrJMlcuEH61UYx3GKQji73YJz30aOqdRgP7+x7C9SQiINdZ/gknSX9nTTJ8W
 QST4PEct2ph5vAYMQFhJSX3EsPXJZiFSjZsMzbJcfkHXb3MZU6uFDt38vvAqPXUqGQvUknx+u6h
 p9dN/sSiPxlLBp7v/xxFB8MrlOSt1B54h4ALD+PxZ9JIwTAMI+fHKFOh8bWycqX8Na44SRFG6mF
 PpjM3A==
X-Received: by 2002:a05:600c:4fc3:b0:43d:174:2668 with SMTP id
 5b1f17b1804b1-450ce684b14mr56796825e9.0.1748604943668; 
 Fri, 30 May 2025 04:35:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVAiHCays6owmIaqzT9s1ZDbqz8dccPcgBZRtaLkp6VX/ZpZKxJ2dWzQChS1U7mqSqt3zPTA==
X-Received: by 2002:a05:600c:4fc3:b0:43d:174:2668 with SMTP id
 5b1f17b1804b1-450ce684b14mr56796445e9.0.1748604943253; 
 Fri, 30 May 2025 04:35:43 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7fc1b60sm15903185e9.34.2025.05.30.04.35.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 04:35:42 -0700 (PDT)
Date: Fri, 30 May 2025 07:35:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 kvm@vger.kernel.org, Sergio Lopez <slp@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, Amit Shah <amit@kernel.org>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Helge Deller <deller@gmx.de>, Palmer Dabbelt <palmer@dabbelt.com>,
 Ani Sinha <anisinha@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?iso-8859-1?Q?Cl=E9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 qemu-arm@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Jason Wang <jasowang@redhat.com>, devel@lists.libvirt.org
Subject: Re: [PATCH v4 00/27] hw/i386/pc: Remove deprecated 2.6 and 2.7 PC
 machines
Message-ID: <20250530073524-mutt-send-email-mst@kernel.org>
References: <20250508133550.81391-1-philmd@linaro.org>
 <20250513132338.4089736b@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250513132338.4089736b@imammedo.users.ipa.redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, May 13, 2025 at 01:23:38PM +0200, Igor Mammedov wrote:
> On Thu,  8 May 2025 15:35:23 +0200
> Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
> 
> > Since v3:
> > - Addressed Thomas and Zhao review comments
> > - Rename fw_cfg_init_mem_[no]dma() helpers
> > - Remove unused CPU properties
> > - Remove {multi,linux}boot.bin
> > - Added R-b tags
> > 
> > Since v2:
> > - Addressed Mark review comments and added his R-b tags
> > 
> > The versioned 'pc' and 'q35' machines up to 2.12 been marked
> > as deprecated two releases ago, and are older than 6 years,
> > so according to our support policy we can remove them.
> > 
> > This series only includes the 2.6 and 2.7 machines removal,
> > as it is a big enough number of LoC removed. Rest will
> > follow.
> 
> CCing libvirt folks
> 
> series removes some properties that has been used as compat
> knobs with 2.6/2.7 machine types that are being removed.
> 
> However libvirt might still use them,
> please check if being removed properties are safe to remove
> as is | should be deprecated 1st | should be left alone
> from an immediate user perspective.

Anyone on libvirt side can confirm please?

> > 
> > Based-on: <20250506143905.4961-1-philmd@linaro.org>
> > 
> [...]


