Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FE23C02199
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 13:59:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgOsT-0007on-OG; Fri, 07 Feb 2025 08:58:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mvaralar@redhat.com>)
 id 1tgOsS-0007oF-CO
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 08:58:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mvaralar@redhat.com>)
 id 1tgOsP-0003h2-Ge
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 08:58:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738936715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4ybkpDxhu8xKTs+Y+7/yzdIG4KMftXrJD68DsnKZ67E=;
 b=N4AVxFpZ5hB83QyjyWDKP3fByS/3ZaSneuhT4Pjgf1geR92zQKZkq6qfHDKWlnmC8UpbFk
 Xr0Yny9A60dLBwFRxBb3ElALaFqdugC8isACbvdTKNm2UpQ74Ci8kJm+DbmO50KCVf5VLk
 W66Quo3l0hUz0XAvSMeaVvQgZ9Z3YqY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-NVFMp6APOSaWX0BINq2LEw-1; Fri, 07 Feb 2025 08:58:34 -0500
X-MC-Unique: NVFMp6APOSaWX0BINq2LEw-1
X-Mimecast-MFC-AGG-ID: NVFMp6APOSaWX0BINq2LEw
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4361ac8b25fso11991005e9.2
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 05:58:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738936713; x=1739541513;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4ybkpDxhu8xKTs+Y+7/yzdIG4KMftXrJD68DsnKZ67E=;
 b=dPNu9WTN7AwZN41OEUbU48oMPyeasRfyYrQ+4V5kEpKexP8xJPLmIWE5fVwgNwKBzT
 eXDHxWsudoToKPNgFxw72NYxqPqHwEezGrj5fs14yGnVCnFQ3nVirw8xqykSinuF3lIr
 42yHnAfTzO8DqUEDqi2ItHmDBcRiIijZuV7l3vPC/6m0xGV4SPrx0m21ENThaozw3a3V
 gjOsaHLWek5Ld7cevU1Atf46u/dj2ChQELqbCY/CbyPYA8BqLgT53ivJFR6AaQcyaykw
 NVGw9kRNIxiR6pIcdX3mbcDl5Jso6M2Mb2LVrZol3LTwj+aYnNEB+fX6ieX/QgKKDLhn
 aXqQ==
X-Gm-Message-State: AOJu0YxF3lxD+YUYz17kJp4md96ND7PG9C8W8NGuAeKLU8edu8UgKlO1
 ofJNYAwDHL2J7SUfGtBEuor+tMO62B1BvbOm2tb2BO04qNdjLMELZqDppqSGe39D+wBsec0CbAe
 bZQiaSah3uHfMAJlcsExezNdbjPhfhaId3duybC14KPzMvMPc5r5R
X-Gm-Gg: ASbGncvnhL/HZmdXdZA2IrpEeXhU5OJjX12lS4hZqaiO+mFyQCHQMB6jViLDEepTDf+
 qBYfvW/w/pGjmGSFJJfiOz3GvogytjoX7IGW813M3tOJjLufHoA6bB190XFeIegl2xZwXsx1wHX
 rdMaAYtmK6bcl5eYq/rFTMMvrpoN9B/vsSWIyI+//tRE9J+GABFfV8iLGPXyFBaZva5IRJDswtu
 XyEGQSS64TcoVISNhjoWVuvka9ELJHV0DRcUJfKiMS+1+aoniDmd4IUMXds5bYKxulz2EkTudM=
X-Received: by 2002:a05:600c:3ac7:b0:434:eb86:aeca with SMTP id
 5b1f17b1804b1-43924988cc1mr30625595e9.10.1738936713323; 
 Fri, 07 Feb 2025 05:58:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHWKxqNkRKndTKkmKggWjw0seZyEZD5by0v8O14yZp7nP1WHLcap0rNEWLJlhYsKrY1IvFHAg==
X-Received: by 2002:a05:600c:3ac7:b0:434:eb86:aeca with SMTP id
 5b1f17b1804b1-43924988cc1mr30625285e9.10.1738936712990; 
 Fri, 07 Feb 2025 05:58:32 -0800 (PST)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390d93379fsm93570975e9.5.2025.02.07.05.58.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 05:58:32 -0800 (PST)
Date: Fri, 7 Feb 2025 14:58:30 +0100
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alex Bennee <alex.bennee@linaro.org>,
 Akihiko Odaki <akihiko.odaki@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, Bibo Mao <maobibo@loongson.cn>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Palmer Dabbelt <palmer@dabbelt.com>,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, felisous@amazon.com,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: Call for GSoC internship project ideas
Message-ID: <Z6YRhs/MaVs30Z/R@fedora>
References: <CAJSP0QVYE1Zcws=9hoO6+B+xB-hVWv38Dtu_LM8SysAmS4qRMw@mail.gmail.com>
 <Z6SCGN+rW2tJYATh@fedora>
 <CAJSP0QUn5HHXKnxgt-Gfefz9d4PmRzPbgYv7Hoo=wcyO-rwQEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJSP0QUn5HHXKnxgt-Gfefz9d4PmRzPbgYv7Hoo=wcyO-rwQEQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mvaralar@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Feb 06, 2025 at 10:10:54AM -0500, Stefan Hajnoczi wrote:
> I have added your project idea to the wiki. Please make further
> changes directly on the wiki.
> 
> https://wiki.qemu.org/Google_Summer_of_Code_2025#Adding_Kani_proofs_for_Virtqueues_in_Rust-vmm
> 
> Thanks,
> Stefan
> 

Thanks,

Matias.


