Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21BEBC3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 14:06:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHNb7-0008MJ-UV; Tue, 20 May 2025 10:05:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1uHNav-0008KH-1K
 for qemu-devel@nongnu.org; Tue, 20 May 2025 10:05:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1uHNao-0007N9-VU
 for qemu-devel@nongnu.org; Tue, 20 May 2025 10:05:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747749917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Dqea7MZDYhyQlC4xKO8LGx5epUTJ/uHF9sDafau5YHY=;
 b=Yp/tU+8ypMmPJGg8BOKk3Ua30GypSpQdOf9Dtge1T80XpruhSCzONHsaajsVPALnoenH3h
 6W195sCvspudM79+vuqi1e68ekgz8B320LQiFINhNr/Bf2QcrLhi9UskUSUSTgRk9zIQMe
 u9i6RB8vk71NQ25y+Wjl5hdaUq6y4V8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-94-bVnTc1EAMAylZKevhQ0_1Q-1; Tue,
 20 May 2025 10:05:14 -0400
X-MC-Unique: bVnTc1EAMAylZKevhQ0_1Q-1
X-Mimecast-MFC-AGG-ID: bVnTc1EAMAylZKevhQ0_1Q_1747749911
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2C7151800874; Tue, 20 May 2025 14:05:10 +0000 (UTC)
Received: from localhost (dhcp-192-216.str.redhat.com [10.33.192.216])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 693CB1956095; Tue, 20 May 2025 14:05:07 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: eric.auger@redhat.com, eric.auger.pro@gmail.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 oliver.upton@linux.dev, sebott@redhat.com,
 shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com
Cc: agraf@csgraf.de, shahuang@redhat.com, mark.rutland@arm.com,
 philmd@linaro.org, pbonzini@redhat.com
Subject: Re: [PATCH v3 06/10] arm/kvm: Allow reading all the writable ID
 registers
In-Reply-To: <a706e9a2-0a49-4296-ba0a-8001f433b8b8@redhat.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy Ross"
References: <20250414163849.321857-1-cohuck@redhat.com>
 <20250414163849.321857-7-cohuck@redhat.com>
 <a706e9a2-0a49-4296-ba0a-8001f433b8b8@redhat.com>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Tue, 20 May 2025 16:05:05 +0200
Message-ID: <87jz6bbcoe.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, May 13 2025, Eric Auger <eric.auger@redhat.com> wrote:

> On 4/14/25 6:38 PM, Cornelia Huck wrote:
>> From: Eric Auger <eric.auger@redhat.com>
>>
>> At the moment kvm_arm_get_host_cpu_features() reads a subset of the
>> ID regs. As we want to introduce properties for all writable ID reg
>> fields, we want more genericity and read more default host register
>> values.
>>
>> Introduce a new get_host_cpu_idregs() helper and add a new exhaustive
>> boolean parameter to kvm_arm_get_host_cpu_features() and
>> kvm_arm_set_cpu_features_from_host() to select the right behavior.
>> The host cpu model will keep the legacy behavior unless the writable
>> id register interface is available.
>>
>> A writable_map IdRegMap is introduced in the CPU object. A subsequent
>> patch will populate it.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>> ---
>>  target/arm/cpu-sysregs.h |  2 ++
>>  target/arm/cpu.h         |  3 ++
>>  target/arm/cpu64.c       |  2 +-
>>  target/arm/kvm.c         | 78 ++++++++++++++++++++++++++++++++++++++--
>>  target/arm/kvm_arm.h     |  9 +++--
>>  target/arm/trace-events  |  1 +
>>  6 files changed, 89 insertions(+), 6 deletions(-)
>>

(...)

>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>> index 775a8aebc5d3..8717c5e7695b 100644
>> --- a/target/arm/cpu.h
>> +++ b/target/arm/cpu.h
>> @@ -1088,6 +1088,9 @@ struct ArchCPU {
>>       */
>>      ARMIdRegsState writable_id_regs;
>>  
>> +    /* ID reg writable bitmask (KVM only) */
>> +    IdRegMap *writable_map;
> as it is KVM only we may put it in ifdef CONFIG_KVM block above

Forgot to reply here; the CONFIG_KVM block is gone with a725f3710231
("target/arm/cpu: always define kvm related registers")


