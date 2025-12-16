Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE2F0D5E13D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 18:56:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVaDj-0002V0-7Q; Tue, 16 Dec 2025 13:56:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVaDS-0002Qj-HO
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 13:56:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVaDR-0002AI-1V
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 13:56:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765911366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3v+ZqMFzlTaMSG+hxc1HMkYHlbLFi/r9/3YlpbtiWXc=;
 b=C02ucFRK1Wn5g/4t4L5fpSWdRRVYSpkwajtdJ96pIfwKrOxugveKAltGMWo7JI4CiS5WYe
 IDB3fEjd1m5OmFnlnQGVJepgU5++BnxYUMkfGNqa98Ax5C/HXJgCNEPUQYriAImpDFrUtA
 iKe9waFIPFMiVR1QQeFW4V6FEgUxtGU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-5LkXNSuMPjKN7liqf6AKQA-1; Tue, 16 Dec 2025 13:56:05 -0500
X-MC-Unique: 5LkXNSuMPjKN7liqf6AKQA-1
X-Mimecast-MFC-AGG-ID: 5LkXNSuMPjKN7liqf6AKQA_1765911364
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-88a32bf024cso27117106d6.2
 for <qemu-devel@nongnu.org>; Tue, 16 Dec 2025 10:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765911364; x=1766516164; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3v+ZqMFzlTaMSG+hxc1HMkYHlbLFi/r9/3YlpbtiWXc=;
 b=rolIoSZvXcx7H22ueGZLtEDwYpX7zB4P3N8+o6arNv43y3DWLyA8K3rdb1U0IE+2pu
 nqLEyilVkTOOkFruuq+saj4IZ+31mm/WcASEam/DmMeRitHXnWBFq2jtws3bPt75cv+l
 3dtOcw6aNr2firr6B7zPCyrNrc4DJhw4RY4MEs/Mq87ywoFn1THlRkdJ4e9xwYhoM7/A
 mlxYpBtxbgMg/GnwUQo8WYb7RWT3YW2M/Wvirvdz7X33NjB9Tp3LB7hV9s3wFW7fKYKe
 xGkPqYnCWHOljKVrBXvU+rGZWiwGrONbg9fUoZUia4Rs+MAUFat0gKx/PFo7HA1RHMt4
 wHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765911364; x=1766516164;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3v+ZqMFzlTaMSG+hxc1HMkYHlbLFi/r9/3YlpbtiWXc=;
 b=IZC0uPGAp8gn/tvzepmwqcdo0pkctXBOaWEji4FCHprgZWyw6uNmhzRADBZkvnFlp6
 0s1Tr/RJNzI4ebxUjPiI31rW+4eg0Wcq61LLnQiY7hwSbxrVylrjQwcndIpdp25ED0mA
 9vgUp60OoZFf4ivvgnJqOGVeQn4Z1Y0rmYXByGIafb80QoFGVY9Hm3eahXrQ7LllvteF
 Rzr9xS6m82jChvCKhewbLTj8nh0aPkLavfTLqAp0Fwlx1yfjOp/WI/02rUqGgqgqj09G
 Boc6GOQK5QpSN5cLm3fysznlj57zM6/SHzoqque67ArqJRKp+WFZqarbbcoJjk5kWB0D
 f3ow==
X-Gm-Message-State: AOJu0YzJwSW3WiUY8hiFLnE9n43UyjxfbyU2+WU9N8tBP6eiU8e+u/T3
 nYpgDxI5tkJlkMx9bvP8pTblENBgdrHDwyYCzbge5UIzxbls9lBa7N14SWoBVOqACn0JbzlCgQJ
 9tXVTWYYlTaL8c5A41S0o3JMNJlxIrWzqX9GMVheaVkrU0c7Qo/pWqC/5
X-Gm-Gg: AY/fxX7aMVcLbgbzmf9msw7c/e++gD6QDQGEJhy1HaYkMIUSFYZzkBj4XMXYXwyWJrf
 00ErVDdhjjpwffrtnGJLluG83GaFkF6AWUlOTpVcH6lfGTlNRhCceEPu4D0my+nr14GBJBp8L78
 lgzCPmLH5k+RDi7fzzmiKpgEXeePwjYbASYdwNZ036ZfiYDyLgr+onq3xsBVWzsEGkg3/VjkLLV
 XTWCNZgQz4b93IKOcPHTuxBEFJCSOSzJlr3/vq+LPmazC6xR6KcZ12Wu8rpvV1nMgrHHRrC1SNR
 VZzpx+hhjQHu0c/0oha1sJwVU1oUse/P7Pkow4jd/093pnG1O9HyL6AwbpeGyOFJHzku6qcfxFa
 e7Lo=
X-Received: by 2002:a05:6214:2403:b0:88a:27f1:45b4 with SMTP id
 6a1803df08f44-88a27f15228mr161744476d6.64.1765911364516; 
 Tue, 16 Dec 2025 10:56:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1NqIOa0iRysCTErMs8vf81wO1KvYQ/a8v/n0jgPKWn1kqKh/IVilAwJAfAEg3Nd4jHivJ+g==
X-Received: by 2002:a05:6214:2403:b0:88a:27f1:45b4 with SMTP id
 6a1803df08f44-88a27f15228mr161744156d6.64.1765911364056; 
 Tue, 16 Dec 2025 10:56:04 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8be31b52abbsm241296685a.35.2025.12.16.10.56.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Dec 2025 10:56:03 -0800 (PST)
Date: Tue, 16 Dec 2025 13:56:01 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v3 12/51] migration: Extract code to mark all parameters
 as present
Message-ID: <aUGrQVxApmv6LkQh@x1.local>
References: <20251215220041.12657-1-farosas@suse.de>
 <20251215220041.12657-13-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251215220041.12657-13-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Mon, Dec 15, 2025 at 06:59:58PM -0300, Fabiano Rosas wrote:
> MigrationParameters needs to have all of its has_* fields marked as
> true when used as the return of query_migrate_parameters because the
> corresponding QMP command has all of its members non-optional by
> design, despite them being marked as optional in migration.json.
> 
> Extract this code into a function and make it assert if any field is
> missing. With this we ensure future changes will not inadvertently
> leave any parameters missing.
> 
> Note that the block-bitmap-mapping is a special case because the empty
> list is considered a valid value, so it has historically not been
> present in the command's output if it has never been set.
> 
> CC: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


