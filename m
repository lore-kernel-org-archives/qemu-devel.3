Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E4BDCF34CA
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 21:43:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swTbb-0003XU-1a; Thu, 03 Oct 2024 17:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1swTbZ-0003X4-H4
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 17:43:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1swTbX-0000fs-PV
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 17:43:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727991801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nR3gvsTeUeSK+aIRUGB28gwBzBHYFQhEYR+AW9GuXQQ=;
 b=HoPNPpaKyLcfFr8gcIBb/I/S0QuX1HfCyJBCAfnIMI4eHNm7dfxHdGBEONPtjhRhKFACLw
 tGBaB/RF6iAsjwpS0rIWMuC8O98erfnayW0P7NVXVXWA1nHsZLYNUMkUWR73hvuDq9Xseh
 hP5SHTEMRZpg5nkPbfbLEvUIIko6q9A=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-kSwP7KLaN2OpiwUtoxTMmw-1; Thu, 03 Oct 2024 17:43:20 -0400
X-MC-Unique: kSwP7KLaN2OpiwUtoxTMmw-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7ae5c5ba98bso231420685a.0
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 14:43:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727991800; x=1728596600;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nR3gvsTeUeSK+aIRUGB28gwBzBHYFQhEYR+AW9GuXQQ=;
 b=oJY/h43g+f3hLrMoohbFfcwt5u9JaNbIT5sj3ibLyo81VpnvCeo11gVeYlEdsv+tT6
 NJI201bcX62SNza+aJ+U6IINhlRu6ktxe1Rje9T4B77B+/2dz45JIys5WzfwfdeIJ3cN
 3ca/D5mvk2Tblo6slIlDhf8yXPegaObbKRODNdCPST987D2XFIl/Xe9xbAOxU/YusFf7
 JbpJg2lf4V8puEx0XB1UQbdxhXB/jr7V57RM3GRYiC607hAqqj8JCFx8JN1dg+JkozUQ
 9KvXlSqUW6bQ+fKvO/NtSS3TD3hVvYs2X1oZ9HHrP21dgAzGyTGspmqSxJ4ERG3NULuR
 fwxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCVdD9fZFNwZbpyM2FcCtKuRM8tsoyorR5WXLSt6n8ubB8n6tyuKo2dXyZNhwEQJkDhW/7JXGhTsfi@nongnu.org
X-Gm-Message-State: AOJu0YwEo65pTGiKj0u1hvEOnIc02/FwJipOOSeH+2cecrG/DMdE/Tc6
 I/5XjbNZWDNL+xXJmnnryb9+zSfq3oaOE8/wDhT7Lja+vslNecggK/qd+8Pbb+6PIKmGEL/XpQG
 4nf/nJ7IjGrVtItnTERGzGmEG4hVcuBsrt1ATnZF9WqunVTBWqq73
X-Received: by 2002:a05:620a:2697:b0:7a1:e2d4:4ff3 with SMTP id
 af79cd13be357-7ae6f4219b9mr96792285a.3.1727991800200; 
 Thu, 03 Oct 2024 14:43:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/53UMHwmSM1e7BOlwpHt+KhS5OF0e43lF0H85i9xfKHdWbLE/c2fnEfAVmGp683vIAUKDlA==
X-Received: by 2002:a05:620a:2697:b0:7a1:e2d4:4ff3 with SMTP id
 af79cd13be357-7ae6f4219b9mr96787885a.3.1727991799857; 
 Thu, 03 Oct 2024 14:43:19 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ae6b3dae76sm80824085a.113.2024.10.03.14.43.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 14:43:17 -0700 (PDT)
Date: Thu, 3 Oct 2024 17:43:14 -0400
From: Peter Xu <peterx@redhat.com>
To: Michael Galaxy <mgalaxy@akamai.com>
Cc: Sean Hefty <shefty@nvidia.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "yu.zhang@ionos.com" <yu.zhang@ionos.com>,
 "elmar.gerdes@ionos.com" <elmar.gerdes@ionos.com>,
 zhengchuan <zhengchuan@huawei.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 Xiexiangyou <xiexiangyou@huawei.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "lixiao (H)" <lixiao91@huawei.com>,
 "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
 Wangjialin <wangjialin23@huawei.com>
Subject: Re: [PATCH 0/6] refactor RDMA live migration based on rsocket API
Message-ID: <Zv8P8uQmSowF8sGl@x1n>
References: <20240827165643-mutt-send-email-mst@kernel.org>
 <027c4f24-f515-4fdb-8770-6bf2433e0f43@akamai.com>
 <84c74f1a95a648b18c9d41b8c5ef2f60@huawei.com>
 <ZvQnbzV9SlXKlarV@x1n>
 <DM6PR12MB431364C7A2D94609B4AAF9A8BD6B2@DM6PR12MB4313.namprd12.prod.outlook.com>
 <0730fa9b-49cd-46e4-9264-afabe2486154@akamai.com>
 <Zvrq7nSbiLfPQoIY@x1n>
 <DM6PR12MB4313D6BA256740DE1ACA29E9BD762@DM6PR12MB4313.namprd12.prod.outlook.com>
 <ZvsAV0MugV85HuZf@x1n>
 <c24fa344-0add-477d-8ed3-bf2e91550e0b@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c24fa344-0add-477d-8ed3-bf2e91550e0b@akamai.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Oct 03, 2024 at 04:26:27PM -0500, Michael Galaxy wrote:
> What about the testing solution that I mentioned?
> 
> Does that satisfy your concerns? Or is there still a gap here that needs to
> be met?

I think such testing framework would be helpful, especially if we can kick
it off in CI when preparing pull requests, then we can make sure nothing
will break RDMA easily.

Meanwhile, we still need people committed to this and actively maintain it,
who knows the rdma code well.

Thanks,

-- 
Peter Xu


