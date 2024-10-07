Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF9DCFB446
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 15:52:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxq2C-0002Oi-04; Mon, 07 Oct 2024 11:52:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sxq2A-0002L4-Vm
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 11:52:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sxq29-0003A9-JD
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 11:52:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728316348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0PAKksN8xE2hdEYnQbd341d2Fhclc/I8LslQMIyP8Tc=;
 b=UDUNvSPzT7y+89YgSELzx3ZIPRohetw7oiOXdnFIzRAhSPNOtozZm0Yda49MmTYnJN72yX
 xRXlvCFp1xvhqQC96fhHRADGyzV6B00KaTPjuNT7mcIgNeHWK4S6oVIlXCFg+EWuhT8SE4
 HhFxTl8si/rRMMLCVY0WMrhqMTU6M+U=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-vYsW_QwyN2-UfeKDRXEUSQ-1; Mon, 07 Oct 2024 11:52:27 -0400
X-MC-Unique: vYsW_QwyN2-UfeKDRXEUSQ-1
Received: by mail-il1-f200.google.com with SMTP id
 e9e14a558f8ab-3a0cd6a028bso40239435ab.0
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 08:52:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728316346; x=1728921146;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0PAKksN8xE2hdEYnQbd341d2Fhclc/I8LslQMIyP8Tc=;
 b=lQ+OUAaMJvXXtUHfozXS6ZYPKDdW9JhJfUsIitxFc8UzBVvntmiQUPq0yjLIM8J5z2
 WEVuvQeGrLwAPE4JdZJTxacsCTdKq1EYmREjHhzmjSOBbnLYWjt7cWr2PNenBpiazIDO
 6zql/wj6tCbOkrtzFy1crHZIUrGFVY4xNMqaanchw4LoX7NPCH7lA8LoCM2OrgxEDM6+
 ryg/Lk8xL1eRpdHzttF2EKEJ6oWsuFpBEm7uFO7qnRMpN2Mal/t3nnOrdBSPEMWwisgw
 yaz2ExFoVjAaAlD8kh3LoSMhGgGV1rM4EK4PLhEOVLq7bte9ucMnevtziywT+FRTM308
 CqfA==
X-Gm-Message-State: AOJu0YznT/LX1SFG/XEtgtt5HR0Dxq0nPFsFjyxd0Gj4rCpOw1HHi9sF
 iB7D/QO+Nl0t0dBxOvuE2myF18aiSmk/N9lylsn7+f3LRvXBG90o1KyzzYurVRckEIN6OL4m/I5
 eT+4UKPOP/jJnVi42Rl7OWKIj5qb70F/7apuRKDIMA63RkUyoQ1zdVfynQZ8d
X-Received: by 2002:a05:6e02:1a8f:b0:39d:351a:d0a2 with SMTP id
 e9e14a558f8ab-3a375bded13mr104004325ab.25.1728316345918; 
 Mon, 07 Oct 2024 08:52:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbQ2+ZU5DEZnWmKmybu1ljwAa3g26FsGQkf4tPCu/mwCpfoVjCIAUGsSScsvLJIhxOD9qPpA==
X-Received: by 2002:a05:6e02:1a8f:b0:39d:351a:d0a2 with SMTP id
 e9e14a558f8ab-3a375bded13mr104003985ab.25.1728316345520; 
 Mon, 07 Oct 2024 08:52:25 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a37a7e790bsm14011445ab.10.2024.10.07.08.52.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2024 08:52:24 -0700 (PDT)
Date: Mon, 7 Oct 2024 11:52:22 -0400
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V2 06/13] hostmem-memfd: preserve for cpr
Message-ID: <ZwQDtrUxg1eYMfwL@x1n>
References: <1727725244-105198-1-git-send-email-steven.sistare@oracle.com>
 <1727725244-105198-7-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1727725244-105198-7-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Sep 30, 2024 at 12:40:37PM -0700, Steve Sistare wrote:
> Preserve memory-backend-memfd memory objects during cpr-transfer.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


