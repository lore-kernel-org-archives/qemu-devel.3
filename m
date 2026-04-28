Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D09A5FF8868
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 15:36:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHkU8-0004LN-NW; Tue, 28 Apr 2026 11:36:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wHkU7-0004L9-09
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 11:36:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wHkU4-0007Js-ON
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 11:36:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777390581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t128JrGOnXO72i6HPdI/pEtn2LJPFca8lBQqfa3tH5U=;
 b=ZZTYwGv8lUInFvdsdK/jFbZrQg4ZVsr3Qz20YRi3KevT6NzvbrY4LgrPM/ri6YuCWE/DJC
 kP6ECg8SBZsNA0vOBJqQlOIiq68EZBn1xcdWpLmcU5e1ZtpudKE5V4GUJcTH1yDzcF+YRZ
 OxtH89odOZkG2j/+0Fgyizw8eR13tQM=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-EbyXJJBFPbCYiW-x5Aviug-1; Tue, 28 Apr 2026 11:36:20 -0400
X-MC-Unique: EbyXJJBFPbCYiW-x5Aviug-1
X-Mimecast-MFC-AGG-ID: EbyXJJBFPbCYiW-x5Aviug_1777390580
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-950bdef305bso17902224241.3
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 08:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777390580; x=1777995380; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=t128JrGOnXO72i6HPdI/pEtn2LJPFca8lBQqfa3tH5U=;
 b=I3oANQHyJX5GJXDGkRqT1F9ncav6LqWDPbtCqvboYF0egBVcy0AqM72mO2UQEvnKls
 uRI4pncY0cfOOeJHlZ1w9yzqB7+mtsB4C9WAwedK5zelFRmTVohWrQXB8tTsYnRdtqbi
 eQAkohdZP4ml4xtX5lyLfg+aDROpzXgGDMhOK7yCKLIj64MxKKB3kJEyqIfs8ektOyd+
 6fdl42TwZhxQUPixIkvTomcsnq3ES9ZEr5mJTR8c5K9b77BDen6Y3B76MSLqkRGTTJqY
 3kO+f2oYtTnre4eWn6Slgg2pmPaK5KphR+c7Z5InAeygyH91TJo+j2VE9eQ+oGimtH4j
 JgUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777390580; x=1777995380;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t128JrGOnXO72i6HPdI/pEtn2LJPFca8lBQqfa3tH5U=;
 b=QtFoA9O/F07HdEaJGc9bhrBAbkZifY98qmOGFGap8gjinrfswqMbLdFYbhryAWcYhs
 xfULZZf1qFMk7wiipMvqDJHLx39W8r6e2vcs5AzWaDPttMDTVNBP1FxBu6IDSlCQYSMQ
 iJc3WnKt11oq3ZM25YYQ4z8iz9HkKd1zWwWIky9e8aykxi18qblVVmEeL+B5fcpzKNQj
 RClem8JJhq2pbVqx7mljf+7LpbQ5MC8sIXahQuCy4eKk94l6bLtuE4FNryw90FChMX1p
 sukO0md3kMhnKRzaET4/bjHwfaSazmzhRic9JSqinWjdlNDxkIzxFhUl6fMJo7vmvCNy
 3MyA==
X-Gm-Message-State: AOJu0YwAH1NJD+uNZEjy/NryXP3H+cRh06ZN2V3AT/iEQWYu+Yzo5UuU
 Tc+WwsAwGQMc6Vfqf7sYTYK68k25rA1s0TjyjpX8S6dnjg76DeBS5QeuKkVEdilK7DAgPM8lli1
 GbdB8l/wy+vLk6sGrG93wWWbA5rXoROKyGLDsgPVJpusT1ixTJIDFa4/Y
X-Gm-Gg: AeBDietaM6QNMnad6of95rDGIipWqq7vVOieEy7i+3v/KXha48+Y6OSnb97ccLjV1Uv
 xHS2KeUV/dgUgoqFbHLAZo6vi9vXZvu39WmmGNqG/RjIfj/HCd6CjhF/r3RJaCK0QEOCOTED2Zr
 b4CZPKaeFD8a4Nn24hZCxIsdKtYlUZ0bw/w5NjL402aXW6QaeYgQP42+vcKfUI/KcBkhTI4l/tE
 tAjplulNgw8Tsl85uAKhPfr93DfJfmt89BUbqY7JzXvfrrsmFsjKgTUH52Rfd1WsGU6AgMT7aj3
 cNCSXqmBvrByrUkwSw1uKZVJEIEfax80775mMLh4IpWFfvL8VlVV9hvmIaPZFk3loCPyDpL78vW
 EsMIbdRkvSzW4lhVqvVqoP70PsMMv7w3GB+M5DW7NAr5+MYnQ0tjzRWj6VA==
X-Received: by 2002:a05:6102:1497:b0:609:af4a:380 with SMTP id
 ada2fe7eead31-629254876e7mr244718137.11.1777390579630; 
 Tue, 28 Apr 2026 08:36:19 -0700 (PDT)
X-Received: by 2002:a05:6102:1497:b0:609:af4a:380 with SMTP id
 ada2fe7eead31-629254876e7mr244654137.11.1777390579016; 
 Tue, 28 Apr 2026 08:36:19 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5100da4cbd3sm21138661cf.4.2026.04.28.08.36.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 08:36:18 -0700 (PDT)
Date: Tue, 28 Apr 2026 11:36:16 -0400
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Li Zhijian <lizhijian@fujitsu.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Zhang Chen <zhangckid@gmail.com>,
 Juraj Marcin <jmarcin@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 0/3] Three small fixes over qom-list-properties crash
Message-ID: <afDT8OhOB6UM_Xd7@x1.local>
References: <20260423183212.468047-1-peterx@redhat.com>
 <87h5p0vo38.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h5p0vo38.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.109,
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

On Fri, Apr 24, 2026 at 09:01:31AM +0200, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > Markus's report is here:
> >
> > https://lore.kernel.org/r/87a4uvw066.fsf@pond.sub.org
> >
> > These three that are relevant to either migration or memory, so I had a
> > look.
> 
> Thank you!
> 
> Series
> Tested-by: Markus Armbruster <armbru@redhat.com>
> 
> Suggest to include the reproducer in the commit messages.
> 

I saw Marc-André sent a more comprehensive series; I'll drop this one then.
Thanks for taking a look.

-- 
Peter Xu


