Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0897CCCF9F8
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 17:10:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEW8Z-0005ii-O0; Thu, 30 Oct 2025 13:08:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vEW8Q-0005i0-Ss
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 13:08:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vEW8F-0006N7-LW
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 13:08:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761844083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BrqUuFYlJ2O0fP30ruRulbDdOneovavEvqADPMU6Fik=;
 b=aStYtt5rvQlf46rvaP/mE4hxL/Y1DWHTOVbo/awzwfid6EEpS4bSDoOHS/KizUIHmbR+wz
 i3E5ki64TZQ7/RdKmEazb/KYrosiukm7gk9RQsMpw8oi5+O3jnOIK8vTDR6cSbfozNCmQ8
 VaSBkkzI5iSLahWHG4HF7EPFA6Hj0HM=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-S3GsNLFnNaGiBrvPfIwzXA-1; Thu, 30 Oct 2025 13:08:01 -0400
X-MC-Unique: S3GsNLFnNaGiBrvPfIwzXA-1
X-Mimecast-MFC-AGG-ID: S3GsNLFnNaGiBrvPfIwzXA_1761844081
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4e892acc0b3so30880061cf.2
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 10:08:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761844081; x=1762448881;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BrqUuFYlJ2O0fP30ruRulbDdOneovavEvqADPMU6Fik=;
 b=gPoQCNoZp+18uvRnDJ3Vdq9zzdqwzD5E2h2SChQlARhI+e8UqrvIlwj01iLBPRRbF9
 otTtpe6szQ6B4wZI9w5NSGqWBUUKT3uwBhOVLiuJl3j2UbnNdTwfXybhGO9JCqMgNRTo
 /mcYzCIXQVcTNGGnUJ+IBExXD4/ilJxmiPQKW5gGttda9TcA4soJfa+hiX+XQyAAJQjU
 Lre8sUx86OI6dxpsYx6Qzq4L0O7owGgJ4sAbhBZlStl9+UW2Fp9U3t1LQ/666zmCn+GH
 UgIufaB5oiYGZshzctTRBznh/WmHgSVOb2JJWKZeshshaN6txsSpYjAVMcOAExPn6OfX
 Hozw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiPRMueeBkDh2+1Udiqd7A9oyNL8nlF6NRw63LnhMmq5vMQTOUFBX57eviTdET0QQp9set2raxHs16@nongnu.org
X-Gm-Message-State: AOJu0Yzz8Jvy3qC4EDwJcrg70XDX88ylkVVz82JU8FpQHNwo6d/NZzRN
 xNSkOtEb1H44xXUNzCXixzaw/5RvbVZrF4PA2aulb5ppSdmvm+dGfG2wgrtjLxyENBhHpRzIc6+
 ngKjNo0Ytsx771xyuF3/PdF25JrRYY41IkbRmeuljKX9rd6bMKkHAjr9o
X-Gm-Gg: ASbGncvjTHIQjEXC0vUCQaOlGoRvwE94e8OkvErxcblY8V7O22Coya/9eQdkwSK4hAZ
 JJksRom+7M1yK8KYq1dTkBhNpzkBJk8jxx3VqczoDKT/4UY7UDmrYrz/kksswlFmdpwLyxltOkK
 rsByO15V6vz8RmEf/4rGyI+Zq2CxE46knf7hTa5nfCJmeJmWzLG6rRDMopWib/+OD7pdE/mXvFI
 QtiC2pY1cyYMR/OY/iIOYxSJi5tmrWldF2FFJviItinVaN+leDvfueAvzOebdpYlt++2oJKGMds
 aOJQFsXGFryhdVFYmwUFFgw0NPOMw8ETVGG9dp1pO1DyT27iAtsP40fGHsPpi8VvmYk=
X-Received: by 2002:ac8:5e12:0:b0:4ed:214f:fb6c with SMTP id
 d75a77b69052e-4ed3109dcffmr3969911cf.75.1761844080962; 
 Thu, 30 Oct 2025 10:08:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfphtykGWAmtv+H30X51a+9P5I6pi2YAx4k7ANngx8JnDGCe6yoUFZ5Lfg5w2a/NmCOij0nQ==
X-Received: by 2002:ac8:5e12:0:b0:4ed:214f:fb6c with SMTP id
 d75a77b69052e-4ed3109dcffmr3969441cf.75.1761844080531; 
 Thu, 30 Oct 2025 10:08:00 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ed308cf3easm1860921cf.16.2025.10.30.10.07.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 10:07:59 -0700 (PDT)
Date: Thu, 30 Oct 2025 13:07:57 -0400
From: Peter Xu <peterx@redhat.com>
To: Ben Chaney <bchaney@akamai.com>
Cc: steven.sistare@oracle.com, farosas@suse.de, hamza.khan@nutanix.com,
 jasowang@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 sgarzare@redhat.com, johunt@akamai.com, mtottenh@akamai.com,
 Mark Kanda <mark.kanda@oracle.com>
Subject: Re: [RFC V2 0/8] Live update: tap and vhost
Message-ID: <aQObbaloT8oW3YsR@x1.local>
References: <1752777568-236368-1-git-send-email-steven.sistare@oracle.com>
 <20251030165223.508678-1-bchaney@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251030165223.508678-1-bchaney@akamai.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, Oct 30, 2025 at 12:52:23PM -0400, Ben Chaney wrote:
> > Tap and vhost devices can be preserved during cpr-transfer
> 
> Hi Steve,
> 
>     I tested this patch set. With the two fixes. it is working
> as expected. Are there plans for a v3 of this patch set?

Steve has retired.

Copy Mark Kanda <mark.kanda@oracle.com>.

-- 
Peter Xu


