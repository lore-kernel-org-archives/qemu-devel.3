Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7449DE77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 20:24:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO0aT-0001QN-UV; Wed, 18 Dec 2024 15:24:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tO0aR-00019o-Jb
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 15:24:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tO0aQ-0000gs-3h
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 15:24:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734553441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ezaRWti1ErAgvhBBuNFOjgjnUx3jkq1qlkzYQdz0JYk=;
 b=P3HI/lLvRep1Tx69sE3Sp/dxZGO1mg25TGusYuPmdrQTGzYuzTFR7Z9Gr6KKyjl6HwO1nw
 vooQ0g4YAcdUyq+yRWV2a1O0/ujxdnhZC5bGlQj2GTybyW+pI/8ysanRhapgpP6RZBGZt8
 xOTj3uvTm+8uQkg1cqTEDTQ2URfHz08=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-uSMSZNHRNtOQ2i2w2cMisQ-1; Wed, 18 Dec 2024 15:23:56 -0500
X-MC-Unique: uSMSZNHRNtOQ2i2w2cMisQ-1
X-Mimecast-MFC-AGG-ID: uSMSZNHRNtOQ2i2w2cMisQ
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7b6e9fb0436so2587885a.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 12:23:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734553436; x=1735158236;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ezaRWti1ErAgvhBBuNFOjgjnUx3jkq1qlkzYQdz0JYk=;
 b=NbiI5Fa+Q9WT1gNrlDlvzol0jEFBWx9YBgPBSllv5+LKhpIJaUGhnYofJG9dNfpw/G
 fENgDhVPySl+XbNEZFIUjeX7Vc9Y4ychq5VNDj2O26pCK82LGm84PV0olWBtWJ5UZZLt
 ZrQi60WHOpcTpqCnhlWoG6/52N4TiRTT/7eklLPq9cTy3XMX95mCDyYKhk4tfUwEP4eh
 sq7bF1RFBqZMPvXk0+A9dtvZcZAfyTwuyqvDUqEs1/wPBk0ZSjA/VwpsZ0Eisztb6yQU
 QSIgVG2Cd/TGtIkyll3QRDxF8n7P3ghETOKxfydojrtmxIUEF6RRe9dr+uubl1A6LlJH
 Crqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVztuBGKFdVmA71bGTBFJ0A22C2V+qXIL96xockNg5fd+VFOtkkpm08PcjNKpjcL7xFonQ0aCmApFc1@nongnu.org
X-Gm-Message-State: AOJu0YzT3gFMyswZFA2dNFLdFDIhlrA7m57AJp41VIC2o5Cy8G9A7NCo
 hfk0yOD/aKAKyCPUEKz5ETQ/AMlrf1LU1HRzIThW5x2z9JUHw+/XPj08jNqwQA4yzngWMvWSl3d
 pBpKj2Z8VbeaUQYM72GJKVJyuOx1tTCtw0CTm3VQY50MxCrvURdVW
X-Gm-Gg: ASbGncurHgvGc4k3lFYeCUSve8pK5qWxNclKVSK6egOLnlTDYCt4pfbZ/RK/L7zMU61
 wDDdFGXjUiD/vqdOBkU99Qiv37o+TTVY+pTLYmpGypiDa+pdBXMVziRJ7Doi6Ha32wNTIPTAnyy
 pQT+dRt9XcS/7XslkvYHOyM2mTp2r+pirMiK0D+wF9y/JtNr0Gqd76DMKaVXrhUTAR8koddzjTZ
 P8N+QoqFej9PvZf7bDvGJgI7h3QZtGcyfiHj+NpFiumVo2+hCyZ6Xz5da9GKXUMvijpZKck5Ucv
 EITlqUwJlfHqFVt+wg==
X-Received: by 2002:a05:620a:1aa7:b0:7b6:e931:4608 with SMTP id
 af79cd13be357-7b9aa8b57a1mr106649885a.6.1734553436384; 
 Wed, 18 Dec 2024 12:23:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHLuYY9JTJn3CLMoJC10U2G5PxYfX38TKw1GmcLTqS40Q+bzazbjFqrYFNv0V/DD5Cn3keWQg==
X-Received: by 2002:a05:620a:1aa7:b0:7b6:e931:4608 with SMTP id
 af79cd13be357-7b9aa8b57a1mr106647785a.6.1734553436192; 
 Wed, 18 Dec 2024 12:23:56 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b7048d04f0sm462833285a.120.2024.12.18.12.23.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 12:23:55 -0800 (PST)
Date: Wed, 18 Dec 2024 15:23:51 -0500
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH V4 07/19] hostmem-memfd: preserve for cpr
Message-ID: <Z2MvV6yPok-odWdw@x1n>
References: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
 <1733145611-62315-8-git-send-email-steven.sistare@oracle.com>
 <4ac5545c-cbf9-4bfc-8300-826d90e88496@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4ac5545c-cbf9-4bfc-8300-826d90e88496@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

On Wed, Dec 18, 2024 at 02:53:03PM -0500, Steven Sistare wrote:
> Hi Peter, can we upgrade your Acked-by to an RB?  You gave RB to the
> similar patch "hostmem-shm: preserve for cpr"

In this context I don't think there's a major difference, so sure.

-- 
Peter Xu


