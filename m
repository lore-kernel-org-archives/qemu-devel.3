Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99548CF58C6
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 18:07:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLmZj-0001c0-0V; Wed, 19 Nov 2025 13:06:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vLmZh-0001ag-Da
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 13:06:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vLmZf-0002k2-7e
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 13:06:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763575594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zxKk+ZBrfy+3vEGqZdJgfoqPz6L6wSNR8CNOxVRPE4c=;
 b=QZMQ7R7+HF5tQ6rTsV7s1TF+WOkK9P7VaCFiuWTe4N195j8U6fQ4p98B5w56UYf16GdK1u
 MDRsASzPghNPxWgVJUbNKj9F+k3waUs7s0w7yCeVso6syKQIJnnzHCGoq8ydatS1b4QlZu
 JIvVko5hVhzGoadf6HGsfUKi2Y1XEb4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-rhdmPaCzPWKmEaM1KdfPig-1; Wed, 19 Nov 2025 13:06:33 -0500
X-MC-Unique: rhdmPaCzPWKmEaM1KdfPig-1
X-Mimecast-MFC-AGG-ID: rhdmPaCzPWKmEaM1KdfPig_1763575592
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-88051c72070so461156d6.1
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 10:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763575592; x=1764180392; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zxKk+ZBrfy+3vEGqZdJgfoqPz6L6wSNR8CNOxVRPE4c=;
 b=OfxWzkwZIXcN1eT0sXEnxsVw6ZESOtxW7q4mjTExx2s5NIjeIW1UgRNvNoFbyhx5HG
 wrGnNJv4NNwKteFvEoYjgghLTpz4cvwQ7JCot1nRiPDICxTY8b8/DiiMVTxAIXnNenla
 16Jn7mVrOBHy6/fW+XiBcfu/2TJgzo0XIe79aL0G8qW1kEqp05lo0ZjIEZMY2xKEY9ZL
 vSytvgGOr1s+0ohq97TYxO8iVdJ1UwmfuflBub0MzxkIt38TfxANAAWv3uywSBjBK/58
 7aZj47uJ9b7PykpjXdIfDFprShBflhdj25miCIIs2U76vlC0juBVqm/E+XtFPoEtPuJV
 R6xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763575592; x=1764180392;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zxKk+ZBrfy+3vEGqZdJgfoqPz6L6wSNR8CNOxVRPE4c=;
 b=MmS0DvR/6B7y14kAkdQQ9gqhw+9pvDmLzBd01wG8YXOjmonWTMveHFfSOZ/g4vfSuI
 hko2QVXfzfwEobO+DQViZut9TTw26vHj+kBBBW31wipZ3DCOoAaFRAWz+JMPuKFHUMPw
 a7B7FrM+YkQmeD+H/3mimbvvakZ84yFVfsVxYHWDFYPTA/t46KPTpWcM0k9n/EVAaayv
 z1HTZe4b5Pe781w01lw3HLx9e+P8SQWkuT1cMEivKafZ3/lfDrDFVFJ1s/6kUI7pua2M
 lMY75LKDOykqq8k6YoCMAAQSxMn8i5v2lY0KZlcsdJrRi61XPVzAbniDyykxHetgA0P2
 QILg==
X-Gm-Message-State: AOJu0YzyKuB7X7xL1Oz/1XbDBDcgCqFtN8BB7jjRvR5wMqpF5WnkXMWv
 3+xewM1JNH1H28XDm98F3fW5YOaxDcuQiFBZbji4MIohwariDN6nLShN06ifQqRxqN4lWCXU1/n
 Cq7FO+5e4ZD31Munjy+HhleJ4xTkO13I6gvT4sNDvmERqVuKMzSHlCDxhFjpPRhCq
X-Gm-Gg: ASbGncvXNUbB/sq8RkN65Qmp/kElwzeciLsZHL/1Hbqk9K29b/p6wF496OJCf/tVa7q
 6iQCyMQk3YuwTQmcxlp6keL8Q5EYc2fENIKrPZ41dxmzFGc2UaG6m4+8E6R5vnTWUc/76hYvczs
 vGRM1ZBkVNjFG5h3ZE5CI4XvJwGCUuoxjK0ciiZDoPjWVIOd6fcHkuXKertHKPPs13uaUtZ8sse
 KbokPrFmNLJ8oW1i2c8p6X+bJhRVfBcKqWRfJVei87QRvMQjTeYg9NmnA26m2jED+8Y3S6LHaEi
 Peyj5XZ5i1gapcB0WSf38MOurT4V3eRKVpLn5axPzVfwIMLW48fGO+EWS/TmbOGZHaZzPh7whdB
 8A8k=
X-Received: by 2002:a05:6214:20ad:b0:880:48c6:acfb with SMTP id
 6a1803df08f44-8846e1d1ee1mr1615986d6.49.1763575592054; 
 Wed, 19 Nov 2025 10:06:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFA3KddVigP0uQkMDW+wiQ07QNB1nQ4u8CPelnAOsxIbSfbRmY+sPznvOSd7uBlcPTF+2F45w==
X-Received: by 2002:a05:6214:20ad:b0:880:48c6:acfb with SMTP id
 6a1803df08f44-8846e1d1ee1mr1615226d6.49.1763575591593; 
 Wed, 19 Nov 2025 10:06:31 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8846e46a846sm181466d6.18.2025.11.19.10.06.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 10:06:31 -0800 (PST)
Date: Wed, 19 Nov 2025 13:06:29 -0500
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 gengdongjiu1@gmail.com, peter.maydell@linaro.org,
 alistair@alistair23.me, edgar.iglesias@gmail.com, npiggin@gmail.com,
 harshpb@linux.ibm.com, palmer@dabbelt.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 berrange@redhat.com, farosas@suse.de, eblake@redhat.com,
 vsementsov@yandex-team.ru, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: Re: [PATCH 1/5] hw/core/loader: Make load_elf_hdr() return bool,
 simplify caller
Message-ID: <aR4HJQGqCswwH022@x1.local>
References: <20251119130855.105479-1-armbru@redhat.com>
 <20251119130855.105479-2-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251119130855.105479-2-armbru@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Nov 19, 2025 at 02:08:51PM +0100, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


