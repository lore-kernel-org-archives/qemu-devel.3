Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B597CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 09:56:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBUYa-0005Me-DU; Tue, 29 Sep 2026 05:55:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xBUYZ-0005M7-8l
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 05:55:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xBUYW-0007Fe-4t
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 05:55:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790675720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VtzTh+dDCA3XGDOcsGJs5iYbLq9spB0eUO4+f6djXh4=;
 b=LS0qEi43KmirKkcbJ/QRj9rB78XVNZ60u/3wuC4Tx6jH5Hq2Q/e8D0IViEffZqtkfDuYUO
 aQIxB7PP1cEmaLGYPtqxJi1BoaI+7+klqvE8PPD7707JvXiRhrbddb40iWUim/Qh06ww6d
 5/ldLPVSC1URZtskpKkuGO1r3E1XwF8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-LzWZQw04Mdewzgdv4VHg7w-1; Tue, 29 Sep 2026 05:55:16 -0400
X-MC-Unique: LzWZQw04Mdewzgdv4VHg7w-1
X-Mimecast-MFC-AGG-ID: LzWZQw04Mdewzgdv4VHg7w_1790675715
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4887782ab2dso3048229f8f.3
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 02:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790675715; x=1791280515; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VtzTh+dDCA3XGDOcsGJs5iYbLq9spB0eUO4+f6djXh4=;
 b=UBAxiLjRWwo7GfkmFOEPLnHv7m6RllS4LylhzRTf7MZmtv2xmkhTu2vzQtgwkKfbUI
 ap7gzc6EudayXDRncOAJvTiEN0NUaQFKUXRCwIYziR37UQ9ZzKgAxkTgyYibtLuyozkO
 JcBZkqawUekDssIlBILttVqmBNEIuPs0HrTx0sW/enT7QOVBD7xMtc2qZOjuT9nJnrCT
 XAByIEi3vLbizoZU9gBwEqP3okNBZsHTMg1oWlcTV9dVZGHcCtRiWs5hPnev1RFr1qgQ
 0PvfmhSU80oEeBHETFMDwaPp82077rWCJ/wyNsRSzBWq5uDJiAxc/kvuQCkN03s1+yr2
 prlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790675715; x=1791280515;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VtzTh+dDCA3XGDOcsGJs5iYbLq9spB0eUO4+f6djXh4=;
 b=OWGLLj97YK/IEtZKX6yusWXE77DrA2osp9vXx4F1tIHdIWHX/UCyxS53n00fkY0kuY
 5YwEQpECEA8+4HYlhod5FMjqqmkadudequHpu4ox+WCiAdjV0pN1AXlFdHHwabpas34V
 aHioZNMaEtynJsQKq6k8QnHljJHqFuLbjWWlL2Q/KD9qds42hAUo3q3HX+4DGCvY5OPq
 BBVZBJHGoXqNV7Lt28iHBmiA1eoIve7uCZFryhnsemEXVUI9F9V73j4yeW8wsJwoaPxc
 coSjddG4rRBCPs6jfTalKdNWVi7SaA8SFhYxQIgMHfd6jhmm2n9nVXnn5ilWxxK2Phse
 nlnw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw0gBnIhSrGtH/QHN6ppXH1Hqv+evXljY0CyqBmQ9i6te6Nwjwz5/E1gBLzEDx9HTRUA0rKyibF7kzd@nongnu.org
X-Gm-Message-State: AFq9FYKuzRfcYmK+o9Zqx4pIr6NiFZgt5CxQXopm+uSTO/gsGYz7fae0
 vokfi9mYBBew0eWd5FdIKvDmuNJmIfXspEQcxeG34l0egNXlmysO9kTgEjIhFHITMytCefef+EO
 /5RLcMV4ALw3oRAASbCgTGojIpE7c+BOlV1NcJldN48n2ELeakLA48vj1
X-Gm-Gg: AYBFou0gGcdLF706H/bDuvSOc0HSaYOIV2a30RdojbvQjyrbjDPor1nZX+XwouaEYCW
 fXL3w2G5yaPN2oQ6KwEzuNRKB3B/5qUcGYOSLIn4AQuS0wtU9e3mzUQGyJyw7D0gbvrA56Zi8yP
 hzlLCY9kTVWJ5+YnzYA4t35GWhwgSeR8C1dMdd6zBm1EoHI3tow981ro23SWfjhkHP70OQ+XemS
 2rNIlMfRJ6j/9v+8z9wy6fAeOp5ffpOaSmr0Pi0JQOGsds4IujILJCkvmlfCcFvx08B8KSR5v/I
 XKyKqzVT3K4NufNlZIweePQYjPcA+kJ/atg8T59sJTcc8MWHkjer2cUJlwPWSjGyvUL6AQ==
X-Received: by 2002:a5d:5d08:0:b0:487:35c:6e6b with SMTP id
 ffacd0b85a97d-48872a5c2d7mr32483438f8f.12.1790675715240; 
 Tue, 29 Sep 2026 02:55:15 -0700 (PDT)
X-Received: by 2002:a5d:5d08:0:b0:487:35c:6e6b with SMTP id
 ffacd0b85a97d-48872a5c2d7mr32483391f8f.12.1790675714760; 
 Tue, 29 Sep 2026 02:55:14 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af5030037sm3245347f8f.8.2026.09.29.02.55.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 02:55:14 -0700 (PDT)
Date: Tue, 29 Sep 2026 05:55:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>,
 Filip Hejsek <filip.hejsek@gmail.com>, Eric Farman <farman@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
 Szymon Lukasz <noh4hss@gmail.com>
Subject: Re: [PATCH v7 00/12] virtio-console: notify about the terminal size
Message-ID: <20260929055431-mutt-send-email-mst@kernel.org>
References: <20260609-console-resize-v7-0-0c550fdcec15@gmail.com>
 <e6ac40a4ff79b9c603c7548acbd8fad9c0c44c87.camel@linux.ibm.com>
 <20260928054918-mutt-send-email-mst@kernel.org>
 <7ac1826c-3891-4750-b5b9-c5f2a4217396@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ac1826c-3891-4750-b5b9-c5f2a4217396@linux.ibm.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Sep 28, 2026 at 05:21:25PM -0400, Matthew Rosato wrote:
> On 9/28/26 5:50 AM, Michael S. Tsirkin wrote:
> > On Mon, Sep 28, 2026 at 11:30:03AM +0200, Maximilian Immanuel Brandtner wrote:
> >> I would really appreciate it, if this patch-set could be merged. I know
> >> that things can get really busy, but it seems to me that there aren't
> >> any blockers that should prevent this patch-set from being merged
> >> (apart from some minor refactors), even as is.
> > 
> > Why not address the minor comments you got?
> >
> 
> Just to clarify, Max did not write the subject series; he is expressing
> interest in it because he wrote a patch that builds upon it for s390x
> [1]. 
> 
> Now, I'm not asking anyone to take code that isn't ready; but I would
> like to understand if this series is abandoned or if the developer is
> planning to send a v8 so we (s390x maintainers) know what to do about
> Max's patch.
> 
> @Filip, do you plan to respin and address the comments you received? 
> There isn't much, but it looks like there was at least one real bug
> identified.
> 
> Thanks,
> Matt
> 
> [1] https://lore.kernel.org/qemu-devel/20260928090846.2315532-1-maxbr@linux.ibm.com/


This is what I am saying. It's been since June. Whoever wants this,
should clean it up and repost.

-- 
MST


