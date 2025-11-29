Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F35A2D116EA
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Nov 2025 01:23:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vP9gd-0002w0-7n; Fri, 28 Nov 2025 20:23:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vP9gK-0002rh-8v
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 20:23:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vP9gI-0001iR-Qh
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 20:23:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764379402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tZz0QzStaYQHqZm8kSZreJc4ro68jES1JxZ7eYeKKhs=;
 b=Xy/oZpzqF+VNZy//xTHAxP0LDw1a/7+HkaBDG4SZZY0s5IXvaLqf7zW0zkrnsqkJyYz1cu
 3jHDeYMnkbfyw2HaCg6221Uv9FJlSfXrFA4oE5ArVhoqU9j67Tyg/AvGYzDUFWj7D0UPlq
 y+QzKEdXPPSxsBajN2bZ4Rcmbr+XSxc=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-PLFELlN_PzmPZWUtj8cSgQ-1; Fri, 28 Nov 2025 20:23:20 -0500
X-MC-Unique: PLFELlN_PzmPZWUtj8cSgQ-1
X-Mimecast-MFC-AGG-ID: PLFELlN_PzmPZWUtj8cSgQ_1764379399
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-297ddb3c707so18089325ad.2
 for <qemu-devel@nongnu.org>; Fri, 28 Nov 2025 17:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764379399; x=1764984199; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tZz0QzStaYQHqZm8kSZreJc4ro68jES1JxZ7eYeKKhs=;
 b=VqKHY+zMzn9bci62jbPoi6Ib+mryylL9u/jQMn67bJugyURrv/7hPB/tYDwhkMPQ+5
 Q49tB/gql/fZUDlDtE0jutULGh742x8+7qqqmcihCCaqw/h6LOOrRAtj6xjpriM45Kr9
 O9+pGWYq421gb/gKrG7x7epIek/X6/5s6d+UcQ2IRSWaVSyGIsbLEUobg8+RtAjRnmei
 b09/8tVO4G5ULtlGISOtqChYzaNT/vVD7nSyVhZlNZSYnZvCCquacOeF/c7rMgoWqEJE
 MlzPHwyXIQUKQlOAWBisIoz/7HZl4/bJd6OoPqY3WjgatQQt/9wLWuKkGd5kJiGZfEvE
 3xHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764379399; x=1764984199;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tZz0QzStaYQHqZm8kSZreJc4ro68jES1JxZ7eYeKKhs=;
 b=LeqT0UY/Kt0bUO7Sj620sN0XEm+6Cqr+UWidUCcVqafbHLvwBPPMMU36Bhz0wokEtj
 32WWC7DR/5ooWrecifvwxRBkeexdwSbv8kVoBqvdjtMErTfggPRks6ttawsDO9yYC9+1
 ByWez+TRBtNK1aBpIcUhYjEusqllvLvv6Ms5JzR/FDcYjA3nWjZ6tw4yvYLS2r+saxXK
 M0AQpKyC0KI0GfDn5n028jG9Kx/tbLQYvM8/yqj+qmEHzTJDIFR4VdGvTJLY5P9R4Vh1
 sYAtP9PIwFXWS6aSNYNMjMCj6kYDUPEAJiUVFxeK61VxoeNGoOR5ZTJA628I11izjN58
 EhCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEK4A4qvSGiVelU6PdGwGj/pAwOXclwfEorcNM9cjm9Fj3/P+XQQLylt8gn5FIlYw8V3FtAJsEqrED@nongnu.org
X-Gm-Message-State: AOJu0Ywef3g+EQKTTlb+7JZDynw/IndBtzsNet6loje1Utrm1x6gehBa
 at0quNTESenrLCcb97HwqppqzkG9gYGQoG9Mz1y6EIlh3gPVnbphJ3ncikZzlgu7IKXzQk1bLSe
 xdRNahV8fPlp7K2cWuSm4iuvgrdVQSf6X3NAjGpt8ebA5Q3znoEiaRIcI
X-Gm-Gg: ASbGncsv+YXzve7K35CB+7adtg8ApZgDbmiEBgabCEOYq7bE8J/u5Fb5hHOJLvDF5v3
 OGn9LpkDn65XkyNGITTYMW5UgDB9Y7raFAJyk8akHkStQGwA9FggCnvm7+tig5xBEUEzZgPNrFW
 k+N/EWKtftx/YPdsnGWnmvPMxMCl0N0F+RIOLkyyANjnJjprXKStmn1R4czO4RDDW628KsF4lpm
 e/Tw4n8+4BDIYDl6CMIin5gWdnhlaIG3Ar4GzfFXvKIlK2biATNRKJXutlvUEkdnT7p1wR+37Wc
 7ZYH9p+qknxGjRq+lHvpQiZC3jPLEOrRc4rpA1SYHI9stZe8999zyHfScNajczNbe4b0YWD2k1X
 z2TT605Yu0c88J3GbrlKSwS9bw/YLIM75Q47qMX0EPQqCQ3q02g==
X-Received: by 2002:a17:903:40cf:b0:295:ac70:10c4 with SMTP id
 d9443c01a7336-29bab1a5ad8mr192788825ad.47.1764379399476; 
 Fri, 28 Nov 2025 17:23:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9ErO/CDJBlfmUPt3o86QVVKmhR0iK5xwzLo4jc97GKsTFe0R6+LOhyiYNviTBkWA2V6aN2A==
X-Received: by 2002:a17:903:40cf:b0:295:ac70:10c4 with SMTP id
 d9443c01a7336-29bab1a5ad8mr192788565ad.47.1764379398974; 
 Fri, 28 Nov 2025 17:23:18 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au.
 [175.34.62.5]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-be4fbb0094dsm5886210a12.10.2025.11.28.17.23.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Nov 2025 17:23:18 -0800 (PST)
Message-ID: <a003599b-a539-4856-8b35-1439eb92ae90@redhat.com>
Date: Sat, 29 Nov 2025 11:23:12 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] acpi/ghes: Use error_fatal in
 acpi_ghes_memory_errors()
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, mchehab+huawei@kernel.org,
 jonathan.cameron@huawei.com, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, gengdongjiu1@gmail.com, peter.maydell@linaro.org,
 pbonzini@redhat.com, shan.gavin@gmail.com
References: <20251127004435.2098335-1-gshan@redhat.com>
 <20251127004435.2098335-6-gshan@redhat.com> <87o6on7uzd.fsf@pond.sub.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <87o6on7uzd.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.014,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Hi Markus,

On 11/27/25 6:14 PM, Markus Armbruster wrote:
> Gavin Shan <gshan@redhat.com> writes:
> 
>> Use error_fatal in acpi_ghes_memory_errors() so that the caller needn't
>> explicitly call exit(). The return value of acpi_ghes_memory_errors()
>> and ghes_record_cper_errors() is changed to 'bool' indicating an error
>> has been raised, to be compatible with what's documented in error.h.
>>
>> Suggested-by: Igor Mammedov <imammedo@redhat.com>
>> Suggested-by: Markus Armbruster <armbru@redhat.com>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> 
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> 
> I figure I would've split this for easier review, say 1. return bool,
> 2. convert acpi_ghes_memory_errors to Error.  Since you already got
> review, it's probably not worthwhile now.  Next time :)
> 

Nice point, thanks for your review. Lets try to do that next time :)

Thanks,
Gavin


