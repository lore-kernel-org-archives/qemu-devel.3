Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEFC5EE49BD
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 14:48:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soOc5-00084C-Ve; Wed, 11 Sep 2024 10:46:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1soOWx-0006MK-QI
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 10:41:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1soOWu-0005si-Gd
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 10:41:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726065666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ylLQ46RRK0r8akuM+MAjQ7YJk+TYPgJnv3CN/nu5zsE=;
 b=eMuv85/rgZeqqHn940ig7KynE0dmgVw/+KUtP98E5IilFUVtR2Yc1hIvpfBRmktZ8f5Gpt
 RBPObgBKlvt3AU7kUoBQ2iunl+pJx67fg+0ZLwEz39jpOWMt9Ksehxt9E4i2eloT2oDCIS
 07QjJf63VZg/kmoNPEhiTcWmAQQ8YtY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-SOfZvQeQMsiREU2E29Ww5A-1; Wed, 11 Sep 2024 09:40:22 -0400
X-MC-Unique: SOfZvQeQMsiREU2E29Ww5A-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7a9b2b3a2bfso459890485a.1
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 06:40:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726062021; x=1726666821;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ylLQ46RRK0r8akuM+MAjQ7YJk+TYPgJnv3CN/nu5zsE=;
 b=thyzKBY9p2tD5RctkF7YNpDmgZ2FzFZdJnnR5WDJj9ySXxcDCVzn++Ev4YCQxCwJYQ
 l7SAe+lnPqe1JNqNW+U8lEpQTrH7fwaDEKmbQzOsJO0gkj9+qU4V5zrVB+A8oms0/C0k
 IkowjpPciEb2FfFvtgFjln4AAjpUznuT6byDgMURWEtEChV+fHq1kRuot0hUOqW+NQO8
 Ub8Hb9DqgGfjuEDPOhNzSYDlUE2WYGIHWx3lqqmZL1wytpkvfwUWS9aCsrHupD4xsovr
 hsN3577htC/c4L1BTgmlPDYAIaQQVM5yQekW3Vu3xIiQ0Q0oAX+FAF8E/PGA8n7HvU1A
 GDtw==
X-Gm-Message-State: AOJu0YzjW6uaKhByBi0sZYm6SwO0qOxAAeUqfiDEzO6i4Q+QNCbHBqIW
 HMgSlG9fhqO9EoadUs7jqt0YFky/b771IesLXk0dp9RvLKGGT2YrZ/1cWpU+XByePei9hHE7Wib
 hx8x+Z32lqhvvgupx/ggcxks0yeHCEEyRSMiC+NKYvSXFJgk9rqoW
X-Received: by 2002:a05:620a:2454:b0:7a9:a6a7:dc2e with SMTP id
 af79cd13be357-7a9d3a7a33emr403694685a.26.1726062021418; 
 Wed, 11 Sep 2024 06:40:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFe+qt8pwlXDK0mfZ+LtyxQgEnpZe0Z6LEhOSLBDwBTuJnhTlFofajkphGOvjHQEd/U2LJQ2A==
X-Received: by 2002:a05:620a:2454:b0:7a9:a6a7:dc2e with SMTP id
 af79cd13be357-7a9d3a7a33emr403689185a.26.1726062020970; 
 Wed, 11 Sep 2024 06:40:20 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a9a7a1a8d5sm421889085a.116.2024.09.11.06.40.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 06:40:20 -0700 (PDT)
Date: Wed, 11 Sep 2024 09:40:16 -0400
From: Peter Xu <peterx@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 "Richard W.M. Jones" <rjones@redhat.com>,
 Joel Stanley <joel@jms.id.au>, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Corey Minyard <minyard@acm.org>, Eric Farman <farman@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Keith Busch <kbusch@kernel.org>,
 WANG Xuerui <git@xen0n.name>, Hyman Huang <yong.huang@smartx.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Michael Rolnik <mrolnik@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jesper Devantier <foss@defmacro.it>, Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, kvm@vger.kernel.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fam Zheng <fam@euphon.net>, qemu-s390x@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Laurent Vivier <lvivier@redhat.com>, Rob Herring <robh@kernel.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Helge Deller <deller@gmx.de>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Yanan Wang <wangyanan55@huawei.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Klaus Jensen <its@irrelevant.dk>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 08/39] migration: replace assert(0) with
 g_assert_not_reached()
Message-ID: <ZuGdwMYENxER2r6-@x1n>
References: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
 <20240910221606.1817478-9-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240910221606.1817478-9-pierrick.bouvier@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Sep 10, 2024 at 03:15:35PM -0700, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


