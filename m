Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62BE1D374A2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 14:17:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1RJ2-0001LC-Hr; Thu, 17 Oct 2024 10:16:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1RIy-0001KZ-Im
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 10:16:45 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1RIt-0002JI-1t
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 10:16:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729174599; x=1760710599;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=jbN/Yjmmdjf0l59XCJJYXsWIbRhPCyFMSYBXdilqhCk=;
 b=TeaETVQKzU8neegvm+z9kOXmDRpwg5erPFIXHWo8awe7Oaj/ZTBEe6bl
 Rp0WqlrgxBDv5HPDY7WzFP8Z4Gm4M9s4bvFBfQxJJCJpBdYJ/ORXzcAxm
 zAVcOPxEP1U6Yq5TVXB4JwKee55+yHAGTwE497ynt5G9D4ixA/AlOs7BF
 hsrPfSGd1B9RjiLGYFbZ4AMg7xoU/ngu8gU04soz8vkAKQT8NF2/um9GS
 aTiM0+D0MjGHFyxluy4dwI7abFLdhO1Z1VwLXIBQLyNCImaf7w+A5JaQl
 K34D0nUf7o6okGafggU0P2zL/zCkKB5Et+2+cfNZUDUoCjCbSoIIvQk5L w==;
X-CSE-ConnectionGUID: wWY1HaeJTQ+06YAC1SXnwQ==
X-CSE-MsgGUID: mDzAwoLhRHGQsEOYi8W8qg==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="39299376"
X-IronPort-AV: E=Sophos;i="6.11,211,1725346800"; d="scan'208";a="39299376"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2024 07:16:36 -0700
X-CSE-ConnectionGUID: te3D44BFTLC6Fh1Y3auJEg==
X-CSE-MsgGUID: /MzVvsWGQd6nQ6Zc1fStfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,211,1725346800"; d="scan'208";a="78900041"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa010.fm.intel.com with ESMTP; 17 Oct 2024 07:16:34 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Junjie Mao <junjie.mao@hotmail.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC 0/2] rust/qemu-api: Rethink property definition macro
Date: Thu, 17 Oct 2024 22:32:43 +0800
Message-Id: <20241017143245.1248589-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.068,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi all,

This RFC is try to implement the property definition macro in Rust
style, to take advantage of Rust's language features and to eliminate
some of the extra checking burden of the C version.

This RFC would change the way property definitions are defined, making
the Rust version of the interface less like C.

Junjie and I felt that this was a small enough, as well as special
enough case, to get us thinking together about what changes Rust would
bring to the QEMU interface.

Welcome your comments!


Background
==========

Let's start by reviewing the original property definition macro in C
version.

This is the most basic one, "DEFINE_PROP":

#define DEFINE_PROP(_name, _state, _field, _prop, _type, ...) {  \
        .name      = (_name),                                    \
        .info      = &(_prop),                                   \
        .offset    = offsetof(_state, _field)                    \
            + type_check(_type, typeof_field(_state, _field)),   \
        __VA_ARGS__                                              \
        }

This macro, to ensure correctness, needs to consider two places:

 1. "_field" must be the member name of "_state".
   * checked by typeof_field().

 2. "_field", "_type" and "_prop" must be aligned.
   * Type of "field" is checked by type_check().
   * Various variants of the macro bind "_prop" to "_type".

For Rust version macro, "define_property!", performs the first check by
"offset_of!", but the second requirement is not ensured because it
doesn't check if $type matches $field. This makes the current Rust
version more unsafe than the C version. :)


Solution
========

Of course, we can add checks, such as some tricks similar to those in
patch 2 for type inference.

However, manually binding $type and $prop in macros and checking $field
feels like C style, especially since Rust has type inference and trait.

Therefore, we define a trait for types in QEMU that require properties,
and return the PropertyInfo by trait, like:

pub trait PropertyType {
    fn get_prop_info() -> *const PropertyInfo;
}

impl PropertyType for bool {
    fn get_prop_info() -> *const PropertyInfo {
        unsafe { std::ptr::addr_of!(qdev_prop_bool) }
    }
}

(This is a simplified version, and we spend the extra effort to implement
PropertyTypeImpl, to get $field type in a safer way, pls see patch 2 for
details.)

At the same time, using Rust's type inference, the PropertyInfo is
directly obtained in the macro based on the type of $field.

Therefore, from $field, we can derive $type, and thus $prop, so that
these three things can be naturally aligned, and, in turn, we can
eliminate the $type and $prop parameters, from the Rust macro.

Fewer parameter relationships mean fewer errors.

Then for Rust version, user shouldn't encode PropertyInfo in macro
directly, instead he should implement PropertyType trait.


Opens
=====

But because of the change in the way properties are defined, we need to
think about how to support custom PropertyInfo: this happens when QEMU
needs to support different PropertyInfo's for the same type, and Rust
trait can't implement it multiple times for the same type.

There're 2 options:

1. Introduce a new macro to support $prop parameter, and user could
specify their custom PropertyInfo.

This is aligned with original C version and reverts to the current code
prior to modifications.


2. Don't allow the user to override the PropertyInfo of the type. Instead
user can wrap the type in truple struct and then implement trait for the
new truple type. For example,

struct MyBool(bool);

impl PropertyType for MyBool {
    ...
}

This way is more like Rust style, but users have to add ".0" whenever
they want to access the wrapped property value.


In both cases we allow the user to specify the pointer to PropertyInfo.
But there is no way to check if the provided PropertyInfo is consistent
with the property type (afterall, we haven't implemented the property
registration mechanism in Rust yet), and we have to assume the user will
ensure the consistency. So both approaches have the same level of safety.

Which option do you think is better?

Thanks and Best Regards,
Zhao

---
Junjie Mao (1):
  rust/qemu-api: Fix fragment-specifiers in define_property macro

Zhao Liu (1):
  rust/qemu-api: Bind PropertyInfo to type

 rust/hw/char/pl011/src/device_class.rs |  4 ---
 rust/qemu-api/src/device_class.rs      | 48 +++++++++++++++++++++++---
 rust/qemu-api/src/tests.rs             |  4 ---
 3 files changed, 43 insertions(+), 13 deletions(-)

-- 
2.34.1


