Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE425CAC582
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 19:26:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uw3xZ-00054o-Hp; Tue, 09 Sep 2025 15:24:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uw3xX-00054J-EK
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 15:24:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uw3xQ-0004aa-9s
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 15:24:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757445883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K9VxngduPxdW59SyGEUiJfrrlEwjGx1y/BEnh8KK0Yo=;
 b=M0GozAqOunWRNEqhxFTk+/iX/uAeSV+0jnrexfJ9fqQWNbSuGTyaRo6JgQ8lzDJVoEW4XT
 i3wqPoX9ClCIeW4WhuX4kk/ekEw0WDOzWEJfbdBwG6Z39D1XEdfrYAsWm5JjTu/2iX3V1a
 hP17YsyTRAhAQplBP4oIa+EuL5kRFd4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-sHjj9c9gOyiuQ1vTWagTDQ-1; Tue, 09 Sep 2025 15:24:41 -0400
X-MC-Unique: sHjj9c9gOyiuQ1vTWagTDQ-1
X-Mimecast-MFC-AGG-ID: sHjj9c9gOyiuQ1vTWagTDQ_1757445880
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45dd9a66cfbso42810875e9.1
 for <qemu-devel@nongnu.org>; Tue, 09 Sep 2025 12:24:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757445880; x=1758050680;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K9VxngduPxdW59SyGEUiJfrrlEwjGx1y/BEnh8KK0Yo=;
 b=vTIQQJIAXHokq4NUpi3plIBA4rpqpLdpJzIVdhWyGFRwTnboinZVbd1Fv2vJAHdw+J
 /u1jOEt1XUjTlX16j1BduJ9z0C0scPqxdkH3USQ6c4jpSb9pztLyiWoAQ454060oFNsO
 kRfPZhr01EpM9Yqug8LpdMR5qgsyraWBvnHtBtXJbmAOvOYPqYlHPhRjT97amRoxSkye
 +a638W5dD9gMwJ48gGbiIsSEkmKqxzIUFnwn86+d052QLLWGQtP/6EZDikxa22aOlsqX
 MnspmoySF66FQ4IQ6Tkc7nARJRfO/5qq03pkHpo5MSvnuTn/KXew6yLuAX1+BkV58OWQ
 GPbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjucbvww8Su83/SX2XCwTVDLo3DuuUp/0AEV1Nxp4gbeyXjm4XyB+CNocRNOuueLbtw6mH7CGTIvHq@nongnu.org
X-Gm-Message-State: AOJu0YzFQLZvBWJH1S1QxJ2hb1JoPcU6q8Al26EIngWZQBxtHVmJQ2/j
 Tftoybq1nz/mhRX14n3W0Y5dm+iLk0tpAkGusaKAmZfNqXEf2F0yc1FJunXF1RAvNGvjWZw4/zx
 b0mMHg7xig7vaIARMZblCwUBSpmWS/Q/53MlJRxVvdIKrKtI/rNM5zxt/
X-Gm-Gg: ASbGncvL4GaG/Ye35VN7sU0xXqFDiL7zZivtBb3eMalnIZxYTrS35ir5oeZw2RssDNB
 VZWLbV4rwB/cu/FVhJx5ieVF/gZTLTE9b/pNm+OrhC8etQ+A2Exdufqkrjij0iTmo4VjBiHK87j
 K9wiRt2XN/YvUEp/9PG9m315OIzRyCm9mMgurPVep4p9EgOBMA+P1SbO90/cQwsvsMIFznzfvj5
 Y5AQlbn8CLsJC2sl/nuvYHWmiROKuPMptWewl1/YusOCQRMoPtrEdrNoYxHSt3C1OfdLe4VeFs/
 Yz/EjRtb0I5OxnxFIrM8gTDk/HbAky8w
X-Received: by 2002:a05:600c:1d20:b0:45c:b5f7:c6e1 with SMTP id
 5b1f17b1804b1-45df4aced96mr19401495e9.0.1757445880359; 
 Tue, 09 Sep 2025 12:24:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcmhiMcswtsNGC+KfiCqpyBMlmg3Ydqj77CI8WJGvI+nvRTzguafml334eVN4KGtCz6isC9g==
X-Received: by 2002:a05:600c:1d20:b0:45c:b5f7:c6e1 with SMTP id
 5b1f17b1804b1-45df4aced96mr19401395e9.0.1757445879987; 
 Tue, 09 Sep 2025 12:24:39 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:c800:2952:74e:d261:8021])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b9c5c89f2sm311248755e9.14.2025.09.09.12.24.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Sep 2025 12:24:39 -0700 (PDT)
Date: Tue, 9 Sep 2025 15:24:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Filip Hejsek <filip.hejsek@gmail.com>,
 Szymon Lukasz <noh4hss@gmail.com>, qemu-devel@nongnu.org,
 lvivier@redhat.com, berrange@redhat.com, amit@kernel.org,
 marcandre.lureau@redhat.com, pbonzini@redhat.com
Subject: Re: [PATCH v3 0/9] virtio-console: notify about the terminal size
Message-ID: <20250909152424-mutt-send-email-mst@kernel.org>
References: <20200629164041.472528-1-noh4hss@gmail.com>
 <3913e8227c343a5d9bfcc2ac1f01d9bd8eceac7a.camel@gmail.com>
 <aMAwL8q0i6pqcAOn@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMAwL8q0i6pqcAOn@codewreck.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Sep 09, 2025 at 10:48:31PM +0900, Dominique Martinet wrote:
> Filip Hejsek wrote on Mon, Oct 23, 2023 at 05:12:14AM +0200:
> > I have found this 3 year old patch adding virtio console resize
> > support, which seems to have been forgotten at that time. I would like
> > to see this feature merged.
> 
> It's been a couple more years... :)
> 
> Have you had a look at this, or did you find another way of handling
> terminal resizes cleanly enough?
> 
> 
> Thanks,
> -- 
> Dominique Martinet

just resubmit the way Amit suggested at the time.


