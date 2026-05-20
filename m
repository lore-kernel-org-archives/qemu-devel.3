Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3BFCCD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 18:36:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPlma-0004py-DK; Wed, 20 May 2026 14:36:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPlmY-0004nZ-82
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:36:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPlmW-0005kf-MC
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:36:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779302194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Sq9a0pj+6PBmxEP5FYBI0MJLBF3GQ5mobLxANVUV/lU=;
 b=TA+foVgdhnaoA4/qOtOop7CoVU5jvmhWkrd6Jm5KfcuPby3Fkzu1wHfTpqCwx1oFqVETRT
 emJt8D1n1QNg7O8J85ON2/Dbjtt9zpk64N/MDxt/i282YuJx+w/ItVmI5fV8wppNbj3EhQ
 LAOTOJ0jfVrg9V31pnEuaW+FyOyhgFo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-0xFOdZ-0NX-A2taBB_HseA-1; Wed, 20 May 2026 14:36:32 -0400
X-MC-Unique: 0xFOdZ-0NX-A2taBB_HseA-1
X-Mimecast-MFC-AGG-ID: 0xFOdZ-0NX-A2taBB_HseA_1779302192
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-909120afff9so570155185a.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 11:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779302192; x=1779906992; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Sq9a0pj+6PBmxEP5FYBI0MJLBF3GQ5mobLxANVUV/lU=;
 b=MngZXhzZx4GNh8fo2/L7C9sNbtadr8UuaBvqnetTAe2x+Ufp0DuNZAFxJ8hjD/RN9u
 Me+3c9/wiA7ZYUI7BJ1KWzkmyg8q4v7hAXALEIjtxSwmxM3rdIfe1AB3FFOCqvuJRuCF
 fvK/NlGV4Q2vVVpZLcB0PE8NBfIdxfhxWVvi8GJW9y1beQ7bTabpyeg5HzzI0q1fUFGd
 XlgBiabZIS+ov0gjGydNgHfSCrCMY4XpNul5r80zzhkqiaP8ye9oDR3TeHUH3B7mZSFj
 DstcYY+ryKcun3S/10fuBds3CwRYH3jcs9GLwGq9NcJ1v4zRlpvv4riuLMTWh/kcpKY4
 xmSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779302192; x=1779906992;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sq9a0pj+6PBmxEP5FYBI0MJLBF3GQ5mobLxANVUV/lU=;
 b=CqJZJ9UxvroGmUS5Z4t7t+brOQbDpwAFUQTXkZk608Uv8NB/oqjn7bk11NTKKkv3u5
 PdlSB9rFnlx1kggspwYud+e/aHbC0Vb75WyPpcFRxXqK+mwUjvJpsZEPUIJX5wMGNlgF
 jKFKPxyfxmkYMOkmSJD7bxDlyboQEcB30mvMM9pGR2hE0CvpkUEqbkoC8F53+oWdue0t
 48b8ZT/S3bYJpCBCgoeZphhkgdHC0+hggy5Dg8c8vBchK/UGM/kk/+AuKNChhQsc4voM
 v1RITpxZR4q2Ck5W7AyhDQ6QsKXNeY+sZ+qcvi/YYJ1NbBEnabNJ7c5JFOS/NOE0x17R
 Kddg==
X-Gm-Message-State: AOJu0Yzp9cWJKXOxg2XIIrOl/sZbF3w61ccsECmHy7Uvg8HL2vPxJHBm
 l6OUrLphB60bkTRnjbIwl9NOldnmJJsS3ejLh87nLOx6+DQpjFP5R3Zr9Z0VE2Wf8JZY5kbfXzO
 /7NF1tUXqYeCs4U3PwFpBgGiWr3EVcBcSpC6FBKl16OBlYm6LjW9Wy5Qz
X-Gm-Gg: Acq92OGoWvfTPi29vTkH/ASa5bE0b9gyvu+3z+ViUBr/juoIJ56Xp79XA8Aapc7Zun4
 8j3zpBVftPhpGZ5atQCzSuKkaCEkPXpeSU0S/TZByShnh/OpcubX7xezqBMrYiKTD1PVwkxRWxZ
 B4WZTqIc2fzeCz6pDfAmzYLqscqx4YMsGuuEhS1R8J5rQzieT8KnH9Gl87F22Vps2uluGqPnCQ9
 SmpyuY1L4WfZlzy3fXU57yeTX3kBIYsXjn4No/n3RwzHrWntzm15ucg/72AGidtlIaCjzwgj107
 7bjPcQXtIm5FbWSV2BeNSs5i2QgxlA8Ej/XpCqp26W2PdkPxS/OawPziMBRxtNe/YbgdOGOOhcp
 rk98jbKV0DRjR4HNW9n8SVRz5QmfkUgjUGdai1WSyFS7p2Zk=
X-Received: by 2002:a05:620a:4542:b0:8ee:dc47:3b70 with SMTP id
 af79cd13be357-911cef062demr3421818885a.39.1779302192175; 
 Wed, 20 May 2026 11:36:32 -0700 (PDT)
X-Received: by 2002:a05:620a:4542:b0:8ee:dc47:3b70 with SMTP id
 af79cd13be357-911cef062demr3421813785a.39.1779302191606; 
 Wed, 20 May 2026 11:36:31 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-910ba181322sm2221931185a.7.2026.05.20.11.36.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 11:36:31 -0700 (PDT)
Date: Wed, 20 May 2026 14:36:30 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Lukas Straub <lukasstraub2@web.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Kanda <mark.kanda@oracle.com>, Ben Chaney <bchaney@akamai.com>
Subject: Re: [PATCH v1 15/15] tests/qtest/migration: Unify URIs
Message-ID: <ag3_Li75Gt1TLGlM@x1.local>
References: <20260505160915.25558-1-farosas@suse.de>
 <20260505160915.25558-16-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260505160915.25558-16-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, May 05, 2026 at 01:09:14PM -0300, Fabiano Rosas wrote:
> The migration tests have always used localhost migration and therefore
> the same URI for both sides of migration. Change the listen_uri and
> connect_uri into a single uri variable.
> 
> For migrations using sockets, there's the possibility of detecting the
> socket address the destination side is using. For those, keep using
> different variables for migrate_qmp and migrate_incoming_qmp.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


