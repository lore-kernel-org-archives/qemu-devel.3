Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8525AF41807
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:22:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcQl-0007Q8-4d; Mon, 09 Mar 2026 11:22:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vzcQj-0007PJ-8T
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:22:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vzcQf-0002if-NB
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:21:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773069715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S3AWJM+4eVxibfFgjpiz1jLMjG/zA+n2zZGIifc+no8=;
 b=L6WGdgUt+MOa9OKEJ6z4U5R+R8KTuLzCxOmVEM5qDNxhXiANk07hOVUV+hpZgzH1VkGrxy
 LaxbWmSkUB0QTT+zSbpMhot4EO/vp8tyOrmZpZQ4d74s+e52WoRnD9WHZZrG0N0yv1yie0
 WODIQnA2etWKM2r5KO4rWFhfK5MHcMk=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-9oTzrXC7NkS1Or-Rx8M6vw-1; Mon, 09 Mar 2026 11:21:53 -0400
X-MC-Unique: 9oTzrXC7NkS1Or-Rx8M6vw-1
X-Mimecast-MFC-AGG-ID: 9oTzrXC7NkS1Or-Rx8M6vw_1773069713
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-506bac14430so534647591cf.2
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773069713; x=1773674513; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=S3AWJM+4eVxibfFgjpiz1jLMjG/zA+n2zZGIifc+no8=;
 b=hadnX8sLtHtmwi3Sa8biIJLOOltUrRPjAhExvtwuDFi/5up+ejmiuvhoDbiRwLV1mI
 +LyjN6OkF0fd91Rl1m7+sg2J5lpQKOk5tkg8goonwVWQoLJMgVuHdnm2S9VJzIqmNCUV
 BC9P3r4lmjOSLcBZ4w6VvFqy7zlxq6HlyCvlIQuBml2Frl7wd23YPNxKksYf0Y0QvWj0
 upGQ2G3PW/6qw+2LXW+AEZaV3e7tNetGzlLWXNyMHy3xmKuJdSGe6DV8++B5lESkSQSS
 QC30++Ajk0GmLaujxo/ifc4x1rb7CVVBG7BWHBC3HsH8nySOC2TttDFNQIbhdYRvqWAO
 Hzqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773069713; x=1773674513;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S3AWJM+4eVxibfFgjpiz1jLMjG/zA+n2zZGIifc+no8=;
 b=DDHA+4OEADuRUQScNOJm1MrD9x8p1/VjR5WKxHlGwls6zvq8ZvJbusOrWVS/i6VrAy
 3KuY7vDow4HRJyw8+Ri3+ETwy7PHHAtALe76GMh7LCrnqFYAO2ZZW+QjZX/EqBKzZ3ny
 VUHBpO/eXxt+3WTx7PPFHLxNDPtbes6ayBBejoH6e+FOjNIKK8ymtUyrp3RLlXw3Vily
 +Y+k1gT5+lk8Btjc1uQCv/nGk/Vugpl4nDS9KQgH3GHaTNWo1CDti+UqD1DLobiy0189
 ypgjYepldxUXzGgAjh3gupXMcmgwpfPleSGtHQ7d6nrQUx30t4w+M8ma5utap4P+ujZh
 wJog==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1DBab5daredjQ8GNdPg7AfG4DDNvdbKLFqsE2BtzB42Tl0XEkukoUGKtZZuRoOPnUYi3iBccvyqLT@nongnu.org
X-Gm-Message-State: AOJu0YyHSCHuYFDomgDEOigS/Q10w5H/XGZg3wXif5BwFjDq1bOXYC1z
 FxgHVKgjS+n2M/Bx2wmwwmf7Ex3fu60aVLkkI/6mI1FIf+2ivuV2UtsWU05nGb2rDnxOL5A9qy4
 iNxrv9Th+BDsSv1tPJUpyyl8hzUkOF7wHP2g3xrZ9WOHgYXjO0xXUi7Ce
X-Gm-Gg: ATEYQzzYTYOe6I3EyEnZRy4bK1Px03ePG1YBUxLOjem7u+g+QQIMkg8Lg3mvc8pKtFq
 5T2PHBXFC1HmUz87cAfU1aNqNlLpaCf8zQWYHpwZHcY7sqnOpFaJqsP5S3o9Z4CnyaYp0rjlwp4
 Q7IOSjhLzoJBSsHRhS3XH7zNko9JFk4kNq1Sku6XfqJfvlJlcOV9Zg73ESFQcAHo+x3CSBiwPdu
 74WnJQ62sI40m2XZnkjAx01J4FFLMY5q0s7U/FIM5bawqMsZFMj8Ft916qSJdkdWt6APlYrLmDh
 eCizgto8R2gT7U6XYHNXoV1UNTXzAiMpLsdkPyvqOnzTP+HdXiV3G8OG4kIEWdfp4Jcr8BHIcI+
 3UABSnxvE4LyScQ==
X-Received: by 2002:ac8:5ac2:0:b0:509:1ad4:630b with SMTP id
 d75a77b69052e-5091ad46e03mr47873101cf.22.1773069713151; 
 Mon, 09 Mar 2026 08:21:53 -0700 (PDT)
X-Received: by 2002:ac8:5ac2:0:b0:509:1ad4:630b with SMTP id
 d75a77b69052e-5091ad46e03mr47872661cf.22.1773069712679; 
 Mon, 09 Mar 2026 08:21:52 -0700 (PDT)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5091a371f4dsm23622441cf.10.2026.03.09.08.21.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 08:21:51 -0700 (PDT)
Date: Mon, 9 Mar 2026 11:21:40 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org,
 mst@redhat.com, jasowang@redhat.com, clg@redhat.com,
 nathanc@nvidia.com, Yi Liu <yi.l.liu@intel.com>,
 =?utf-8?Q?Cl=C3=A9ment?= Mathieu--Drif <clement.mathieu--drif@bull.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] intel_iommu: Remove 'x-' prefix from 'x-scalable-mode'
 and 'x-flts' properties
Message-ID: <aa7lhJ5E5IY5SEiH@x1.local>
References: <20260309092027.404489-1-zhenzhong.duan@intel.com>
 <aa7P13u3yconC_JU@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa7P13u3yconC_JU@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Mar 09, 2026 at 01:49:11PM +0000, Daniel P. Berrangé wrote:
> On Mon, Mar 09, 2026 at 05:20:27AM -0400, Zhenzhong Duan wrote:
> > We had 'x-scalable-mode' for more than 5 years and 'x-flts' for more than 1
> > year, it's fine to remove 'x-' now.
> 
> I tried to look at history to understand why we used an 'x-' prefix to
> begin with. There doesn't seem to have been a very compelling reason,
> just a suggestion from Peter (cc'd)
> 
>    https://lists.nongnu.org/archive/html/qemu-devel/2019-02/msg02847.html

Yes, at that time scalable mode is at very early stage, and the ABI may be
prone to change, hence the suggestion.  I do have the gut feeling it's
getting much more stable on the interface so it makes sense to remove x-.

Thanks,

-- 
Peter Xu


